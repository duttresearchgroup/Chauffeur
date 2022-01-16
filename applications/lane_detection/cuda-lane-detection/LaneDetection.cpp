#include "commons.h"
#include "HoughTransform.h"
#include "Preprocessing.h"
#include <time.h>
#include <iomanip>

extern void detectLanes(VideoCapture inputVideo, VideoWriter outputVideo, int houghStrategy);
extern void drawLines(Mat &frame, vector<Line> lines);
extern Mat plotAccumulator(int nRows, int nCols, int *accumulator);

int main(int argc, char *argv[]) {
    if (argc < 3) {
        cout << "usage LaneDetection inputVideo outputVideo [--cuda|--seq]" << endl << endl;
        cout << "Positional Arguments:" << endl;
        cout << " inputVideo    Input video for which lanes are detected" << endl;
        cout << " outputVideo   Name of resulting output video" << endl << endl;
        cout << "Optional Arguments:" << endl;
        cout << " --cuda        Perform hough transform using CUDA (default)" << endl;
        cout << " --seq         Perform hough transform sequentially on the CPU" << endl;
        return 1;
    }

    // Read input video
    VideoCapture capture(argv[1]);
    // Check which strategy to use for hough transform (CUDA or sequential)
    int houghStrategy = argc > 3 && !strcmp(argv[3], "--seq") ? SEQUENTIAL : CUDA;
    int frameWidth = capture.get(CAP_PROP_FRAME_WIDTH);
    int frameHeight = capture.get(CAP_PROP_FRAME_HEIGHT);

    if (!capture.isOpened()) {
        cout << "Unable to open video" << endl;
        return -1;
    }

    VideoWriter video(argv[2], VideoWriter::fourcc('M','J','P','G'), 30,
                      Size(frameWidth, frameHeight), true);

    detectLanes(capture, video, houghStrategy);

    return 0;
}

/**
 * Coordinates the lane detection using the specified hough strategy for the 
 * given input video and writes resulting video to output video
 * 
 * @param inputVideo Video for which lanes are detected
 * @param outputVideo Video where results are written to
 * @param houghStrategy Strategy which should be used to parform hough transform
 */
void detectLanes(VideoCapture inputVideo, VideoWriter outputVideo, int houghStrategy) {
    Mat frame, preProcFrame;
    vector<Line> lines;

    clock_t readTime = 0;
	clock_t prepTime = 0;
	clock_t houghTime = 0;
	clock_t writeTime = 0;
    clock_t totalTime = -clock();

    int frameWidth = inputVideo.get(CAP_PROP_FRAME_WIDTH);
    int frameHeight = inputVideo.get(CAP_PROP_FRAME_HEIGHT);

    HoughTransformHandle *handle;
    createHandle(handle, houghStrategy, frameWidth, frameHeight);

    cout << "Processing video " << (houghStrategy == CUDA ? "using CUDA" : "Sequentially") << endl;

	for( ; ; ) {
        // Read next frame
        readTime -= clock();
		inputVideo >> frame;
        readTime += clock();
		if(frame.empty())
			break;

        // Apply pre-processing steps
        prepTime -= clock();
        preProcFrame = filterLanes(frame);
        preProcFrame = applyGaussianBlur(preProcFrame);
        preProcFrame = applyCannyEdgeDetection(preProcFrame);
        preProcFrame = regionOfInterest(preProcFrame);
        prepTime += clock();

        // Perform hough transform
        houghTime -= clock();
        lines.clear();
        if (houghStrategy == CUDA)
            houghTransformCuda(handle, preProcFrame, lines);
        else if (houghStrategy == SEQUENTIAL)
            houghTransformSeq(handle, preProcFrame, lines);
        houghTime += clock();

        // Draw lines to frame and write to output video
        writeTime -= clock();
        drawLines(frame, lines);
        outputVideo << frame;
        writeTime += clock();
    }

    destroyHandle(handle, houghStrategy);

    totalTime += clock();
	cout << "Read\tPrep\tHough\tWrite\tTotal" << endl;
	cout << setprecision (4)<<(((float) readTime) / CLOCKS_PER_SEC) << "\t"
         << (((float) prepTime) / CLOCKS_PER_SEC) << "\t"
		 << (((float) houghTime) / CLOCKS_PER_SEC) << "\t"
		 << (((float) writeTime) / CLOCKS_PER_SEC) << "\t"
    	 << (((float) totalTime) / CLOCKS_PER_SEC) << endl;
}

/** Draws given lines onto frame */
void drawLines(Mat &frame, vector<Line> lines) {
    for (int i = 0; i < lines.size(); i++) {
        int y1 = frame.rows;
        int y2 = (frame.rows / 2) + (frame.rows / 10);
        int x1 = (int) lines[i].getX(y1);
        int x2 = (int) lines[i].getX(y2);

        line(frame, Point(x1, y1), Point(x2, y2), Scalar(255), 5, 8, 0);
    }
}

/**
 * Helper function which plots the accumulator and returns result image (only 
 * for debugging purposes)
 */
Mat plotAccumulator(int nRows, int nCols, int *accumulator) {
	Mat plotImg(nRows, nCols, CV_8UC1, Scalar(0));
	for (int i = 0; i < nRows; i++) {
  		for (int j = 0; j < nCols; j++) {
			plotImg.at<uchar>(i, j) = min(accumulator[(i * nCols) + j] * 4, 255);
  		}
  	}

    return plotImg;
}
