#include "commons.h"

/** Filters white and yellow lane markers from the image */
Mat filterLanes(Mat img);

/** Applys gaussian blur with kernel size 5 to image */
Mat applyGaussianBlur(Mat img);

/** Applyes canny edge detection no given image */
Mat applyCannyEdgeDetection(Mat img);

/** 
 * Crops out region of interest from image. The region of interest is the 
 * region which would usually contain the lane markers.
 */
Mat regionOfInterest(Mat img);
