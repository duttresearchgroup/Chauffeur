# CUDA Lane Detection
CUDA Implementation of a Hough Transform based Lane Detection algorithm.

<img src="https://i.ibb.co/5RM4n5F/Picture1.png" alt="Picture1" border="0">

## Compiling
The program can be compiled on the Linux lab machines using the following command:

```
nvcc -gencode arch=compute_50,code=sm_50 -I/usr/local/include/opencv4 -L/usr/local/lib/ *.cpp *cu -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_videoio -std=c++11 -o LaneDetection.out
```

## Running

The Lane Detection program requires two positional arguments. The `inputVideo` which is a path to the input video and the `outputVideo` which is the path at which the result video is stored.

Additionally, we can add either a `--cuda` flag to use the CUDA implementation or a `--seq` flag to use the sequential implementation. 

Therefore, in order to run it for the test video provided in the repository we can use the following command.

```
./LaneDetection.out ./test-video.mp4 ./result-video.avi --cuda
```
