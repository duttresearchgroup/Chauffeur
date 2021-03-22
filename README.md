# MiSelf: Micro-Benchmark Suite for Designing Self-Driving Vehicles
# Included Microbenchmarks:
- Structure-From-Mothion  =>  OpenMVG (CPU/GPU, C++)
- Object Detection:       =>  Jetson-Inference(Hello_Ai_World) (CPU/GPU, C++)
- Lane Detection:         =>  Jetson TX2 Lane Detection (CPU/GPU, C++)
- Extended Kalman Filter => CarND-Extended-Kalman-Filter (CPU, C++)

# Step 1: Compilation 
We are using dockers to compile the source code of the micro-benchmarks. Please navigate to the `docker` folder and perform the following steps:
* `docker-compose build` : This will prepare the environment to build the applications.
* Check the version of L4T running on the NVidia board with jtop. Download the correct cross compiler corresponding to the L4T version from nvidia's website and place it inside the `cross-compiler` folder. Now this folder should look like this:

![](data/folder-layout.jpg)

* `docker-compose up`: This will utilize the cross-compilers inside the build environment to produce the binaries. 

* [Debug] For using an interactive debugging environment, please run `docker-compose run miself.builder bash`

# Step 2: Deployment on board

# Step 3: Running on board
## Essential dependencies version on Hydra:
- Eigen3 -- 3.3.9
- Ceres Solver -- 2.0.0
- ROS Melodic

# For run application on sample inputs as quick start:
### OpenMVG: 
`$ cd openMVG_Build/software/SfM/`


`$ python SfM_GlobalPipeline.py [full path image directory] [resulting directory]`          

`$ python SfM_GlobalPipeline.py ~/home/user/data/ImageDataset_SceauxCastle/images ~/home/user/data/ImageDataset_SceauxCastle/Castle_Global_Reconstruction`

The asscociate Image_dataset is under the openMVG folder.

### Jetson-Inference:
First you will need to build the project following the instruction on Dusty's website.
There're two way to build it:
- Running the Docker Container  --  https://github.com/dusty-nv/jetson-inference/blob/master/docs/aux-docker.md

- Building the Project from Source  --  https://github.com/dusty-nv/jetson-inference/blob/master/docs/building-repo-2.md


I build the project from source for Hydra.
Then to run Classifying Images with ImageNet:
`$ cd jetson-inference/build/aarch64/bin`
To run C++ sample program:
`$ ./imagenet images/orange_0.jpg images/test/output_0.jpg     # (default network is googlenet)`
To run Python sample program:
`$ ./imagenet.py images/orange_0.jpg images/test/output_0.jpg  # (default network is googlenet)`

##### If you met "failed to open swrast" issue, you could try link the libdrm.so.2 to libdrm.so.2.4.0 (Thank you Hans!)
`$ cd /usr/lib/aarch64-linux-gnu`
`$ sudo ln -sf libdrm.so.2.4.0 libdrm.so.2`

Except for object detection, Jetson-Inference have more features like Locating and Semantic Segmentation in the future that we might need to work with.



### Jetson TX2 Lane Detection:
To build the application, we first need to modify two functions in src/detector.cpp since the updated OpenCV version:

`sudo vim src/detector.cpp`

> line 51: 	CV_FOURCC('M', 'P', 'E', 'G') -> cv::VideoWriter::fourcc('M', 'P', 'E', 'G')
> Line 284:	CV_BGR2GRAY -> cv::COLOR_BGR2GRAY

Then we will need to install the dependencies and then build:


`$./install_dependencies.sh`


`$./build.sh`


`$./build.sh clean`

Then after building the application, we can run the sample with the run.sh we wrote.

### CarND-Extended-Kalman-Filter:
- Clone this repo.
- Make a build directory: `mkdir build && cd build`
- Compile: `cmake .. && make`
- On windows, you may need to run: `cmake .. -G "Unix Makefiles" && make`
- Run it: `./ExtendedKF path/to/input.txt path/to/output.txt.` You can find some sample inputs in 'data/'. eg. `./ExtendedKF ../data/sample-laser-radar-measurement-data-1.txt output.txt`








#### Authors of OpenMVG:
- Pierre Moulon <pmoulon@gmail.com>
- Pascal Monasse <monasse@imagine.enpc.fr>
- Renaud Marlet <renaud.marlet@enpc.fr>

###### anhtuann
- Bruno Duisit
- Fabien Castan
- Iivari Äikäs
- luxigo
- Michael Holroyd
- Romain Janvier
- Rory McCann
- Romuald Perrot
- rhiestan
- sergi pujades-rocamora
- sflotron
- vincentweb
- Yohann Salaun




#### Author of Jetson-inference:
- Nvidia




#### Author of Jetson TX2 Lane Detection:
- jaredraycoleman 
- tainagdcoleman
- antwonn
- fieryWaters

#### Author of CarND-Extended-Kalman-Filter:
- Cameron Pittman
- Dennis Krut
- Jeremy Shannon
- Andrew
- Kyle Stewart-Frantz
- Mike Allen 
- Alex Cui 
- Andrei Vatavu
- Wolfgang Steiner









