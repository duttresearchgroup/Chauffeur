#include <math.h>
#include "commons.h"
#include "Line.h"
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

/** 
 * Handle which tracks info that is required for every execution of hough 
 * transform. The handle allows the hough transforms to reuse variables between
 * executions of different frames.
 */
struct HoughTransformHandle {
    /// Number of rows in the accumulator (number of possible rhos)
    int nRows;
    /// Number of columns in the accumulator (number of possible thetas)
    int nCols;
};

/**
 * Tracks accumulator required for sequential execution. Memory space for the 
 * accumulator needs to be allocated only once for all frames.
 */
struct SeqHandle: HoughTransformHandle {
    /// 2D matrix where votes for combinations of rho/theta values are tracked
    int *accumulator;
};

/**
 * Tracks info required for the CUDA hough transform. Memory space on host as 
 * well as device only needs to be allocated only once for all frames.
 */
struct CudaHandle: HoughTransformHandle {
    int frameSize;
    int *lines;
    int *d_lines;
    int lineCounter;
    int *d_lineCounter;
    uchar *d_frame;
    int *d_accumulator;
    dim3 houghBlockDim;
    dim3 houghGridDim;
    dim3 findLinesBlockDim;
    dim3 findLinesGridDim;
};

/**
 * Initializes handle object for given hough strategy
 * 
 * @param handle Handle to be initialized
 * @param houghStrategy Strategy used to perform hough transform
 */
void createHandle(HoughTransformHandle *&handle, int houghStrategy, int frameWidth, int frameHeight);

/**
 * Frees memory on host and device that was allocated for the handle
 * 
 * @param handle Handle to be destroyed
 * @param houghStrategy Hough strategy that was used to create the handle
 */
void destroyHandle(HoughTransformHandle *&handle, int houghStrategy);

/**
 * Performs hough transform for given frame sequentially and adds found lines
 * in 'lines' vector
 * 
 * @param handle Handle tracking relevant info accross executions
 * @param frame Video frame on which hough transform is applied
 * @param lines Vector to which found lines are added to 
 */
void houghTransformSeq(HoughTransformHandle *handle, Mat frame, vector<Line> &lines);

/**
 * Performs hough transform for given frame using CUDA and adds found lines
 * in 'lines' vector
 * 
 * @param handle Handle tracking relevant info accross executions
 * @param frame Video frame on which hough transform is applied
 * @param lines Vector to which found lines are added to 
 */
void houghTransformCuda(HoughTransformHandle *handle, Mat frame, vector<Line> &lines);
