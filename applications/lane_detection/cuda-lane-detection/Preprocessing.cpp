#include "Preprocessing.h"

#define KERNEL_SIZE 5

/** Filters white and yellow lane markers from the image */
Mat filterLanes(Mat img) {
	Mat hsvImg;
	Mat grayImg;
	cvtColor(img, hsvImg, COLOR_BGR2HSV);
	cvtColor(img, grayImg, COLOR_BGR2GRAY);

	Mat yellowHueRange;
	Mat whiteHueRange;
	Mat mask;
	inRange(hsvImg, Scalar(20, 100, 100), Scalar(30, 255, 255), yellowHueRange);
	inRange(img, Scalar(120, 120, 120), Scalar(255, 255, 255), whiteHueRange);
	bitwise_or(yellowHueRange, whiteHueRange, mask);
	bitwise_and(grayImg, mask, grayImg);

	return grayImg;
}

/** Applys gaussian blur with kernel size 5 to image */
Mat applyGaussianBlur(Mat img) {
	GaussianBlur(img, img, Size(KERNEL_SIZE, KERNEL_SIZE), 0);
	return img;
}

/** Applyes canny edge detection no given image */
Mat applyCannyEdgeDetection(Mat img) {
	Canny(img, img, 50, 150);
	return img;
}

/** 
 * Crops out region of interest from image. The region of interest is the 
 * region which would usually contain the lane markers.
 */
Mat regionOfInterest(Mat img) {
	Mat mask(img.rows, img.cols, CV_8UC1, Scalar(0));

	vector<Point> vertices;
	vertices.push_back(Point(img.cols / 9, img.rows));
	vertices.push_back(Point(img.cols - (img.cols / 9), img.rows));
	vertices.push_back(Point((img.cols / 2) + (img.cols / 8), (img.rows / 2) + (img.rows / 10)));
	vertices.push_back(Point((img.cols / 2) - (img.cols / 8), (img.rows / 2) + (img.rows / 10)));

	// Create Polygon from vertices
	vector<Point> ROI_Poly;
	approxPolyDP(vertices, ROI_Poly, 1.0, true);

	// Fill polygon white
	fillConvexPoly(mask, &ROI_Poly[0], ROI_Poly.size(), 255, 8, 0);
	bitwise_and(img, mask, img);

	return img;
}
