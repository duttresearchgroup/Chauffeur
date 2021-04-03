# Chauffeur: Micro-Benchmark Suite for Designing Self-Driving Vehicles
# Included Microbenchmarks:
- Structure-From-Mothion  =>  OpenMVG (CPU/GPU, C++)
- Object Detection:       =>  Jetson-Inference(Hello_Ai_World) (CPU/GPU, C++)
- Lane Detection:         =>  Jetson TX2 Lane Detection (CPU/GPU, C++)
- Extended Kalman Filter  =>  CarND-Extended-Kalman-Filter (CPU, C++)
- Lane-Detection          =>  LaneNet-Lane-Detection(GPU, Pythoh/C++)
# Step 0: Download Chauffeur :)
```
git clone https://github.com/duttresearchgroup/Chauffeur
cd Chauffeur
git submodule update --init --recursive
```
# Step 1 Compilation
## (Cross)  using qemu based docker
We are using dockers to compile the source code of the micro-benchmarks. Please navigate to the `docker` folder and perform the following steps:
### Setting up qemu based cross-compiler env
* `sudo apt-get install qemu binfmt-support qemu-user-static # Install the qemu packages`
* `docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts`
* Pleaser refer [to this link](https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/) for more details. 

### Setting up docker
* follow instructions [here](https://docs.docker.com/engine/install/ubuntu/) to make sure docker is installed

### Getting the virtual L4T ready
* `sudo apt install docker-compose`
* `docker-compose build` : This will prepare the environment to build the applications.
* You can check the version of L4T running on the NVidia board with jtop. 
* This is the most time-consuming step of the process. Remember to grab your coffee at this point. We are downloading all the necessary tools so that you don't have to compile on the board.
<!-- Download the correct cross compiler corresponding to the L4T version from nvidia's website and place it inside the `cross-compiler` folder. Now this folder should look like this:

![](data/folder-layout.jpg) -->
### Ready to cross compile
* `docker-compose up`: This will utilize the compilers inside the build environment to produce the binaries. By default it calls the `build.sh` script which builds the applications one by one and produces the final binaries in a `applications/bin` folder. Once the applications are generated, you are ready to run them!

* [Debug] For using an interactive debugging environment, please run `docker-compose run Chauffeur.builder bash`

## Compilation on the board
```
source scripts/env.sh
bash scripts/APP_NAME/build.sh [tx2/px2>] 
(e.g., bash scripts/darknet_ros/build.sh tx2)
```
# Step 2: Deployment on board
* Please ensure that `rsync` is installed in both host and target, and additionally `sshpass` is installed on host. 
* In `scripts/remote_sync.sh` modify the remote credentials where you want to deploy. 
* Create a file called `scripts/passwd` to store the ssh password.
* Next using `bash` shell execute `scripts/send.sh applications/bin bin`. If you are using VSCode, we already include a 'Send Binaries' task.
# Step 3: Running on board
* `source scripts/env.sh`
* In `scripts` folder we have include the relevant launching script `run.sh` for each application. For example, to run application kalman_filter, `sh scripts/kalman_filter/run.sh`
* For cross compiled environment, pass `cross` as an argument to the file. Example:  `sh scripts/kalman_filter/run.sh cross`.



# Other important information
## Essential dependencies for running Chauffeur:
- Eigen3 -- 3.3.9
- Ceres Solver -- 2.0.0
- ROS Melodic
- TensorFlow - 1.15 (For LaneNet-Lane-Detection)
- OpenCV (with CUDA) -- 3.4.13


Instruction for installing TensorFlow 1.15 for Python3.6+JetPack4.4. Source from https://forums.developer.nvidia.com/t/tensorflow-for-jetson-tx2/64596 \
```
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip
sudo pip3 install -U pip
sudo pip3 install -U pip testresources setuptools numpy==1.16.1 future==0.17.1 mock==3.0.5 h5py==2.9.0 keras_preprocessing==1.0.5 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==1.15.4+nv20.12
```

## Quick start
### OpenMVG: 
[https://github.com/openMVG/openMVG](https://github.com/openMVG/openMVG)

`$ cd openMVG_Build/software/SfM/`

`$ python SfM_GlobalPipeline.py [full path image directory] [resulting directory]`          

`$ python SfM_GlobalPipeline.py ~/home/user/data/ImageDataset_SceauxCastle/images ~/home/user/data/ImageDataset_SceauxCastle/Castle_Global_Reconstruction`

The asscociate Image_dataset is under the openMVG folder.



### CarND-Extended-Kalman-Filter:
[https://github.com/jeremy-shannon/CarND-Extended-Kalman-Filter-Project](https://github.com/jeremy-shannon/CarND-Extended-Kalman-Filter-Project) \
Clone this repo. \
Make a build directory: `mkdir build && cd build` \
Compile: `cmake .. && make` \
On windows, you may need to run: `cmake .. -G "Unix Makefiles" && make` \
Run it: `./ExtendedKF path/to/input.txt path/to/output.txt.` You can find some sample inputs in 'data/'. eg. `./ExtendedKF ../data/sample-laser-radar-measurement-data-1.txt output.txt` \








# Thanks the Authors for all these applications!
[Authors](https://github.com/duttresearchgroup/Chauffeur/files/6209700/Authors.txt)
















