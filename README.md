# Chauffeur: Benchmark Suite for Design and End-to-End Analysis of Self-Driving Vehicles on Embedded Systems

# Step 0: Download Chauffeur :)
```
git clone https://github.com/duttresearchgroup/Chauffeur
cd Chauffeur
git submodule update --init --recursive
```
# Step 1 Compilation
## (Cross)  using qemu based docker
We are using dockers to compile the source code of the micro-benchmarks. Please navigate to the `docker` folder and perform the following steps:

### Setting up docker
* follow instructions [here](https://docs.docker.com/engine/install/ubuntu/) to make sure docker is installed

### Setting up qemu based cross-compiler env
* `sudo apt-get install qemu binfmt-support qemu-user-static # Install the qemu packages`
* `docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts`
* Pleaser refer [to this link](https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/) for more details. 

### Getting the virtual L4T ready
* `sudo apt install docker-compose`
* `cd docker`
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
* In `scripts/envs.sh` modify the remote credentials where you want to deploy. 
* Create a file called `scripts/passwd` to store the ssh password.
* Next using `bash` shell execute `scripts/send.sh cross-apps/ applications/`. If you are using VSCode, we already include a 'Send Binaries' task.
# Step 3: Running on board
* `source scripts/env.sh`
* In `scripts` folder we have include the relevant launching script `run.sh` for each application. For example, to run application kalman_filter, `sh scripts/kalman_filter/run.sh`
* For cross compiled environment, pass `cross` as an argument to the file. Example:  `sh scripts/kalman_filter/run.sh cross`.



# Other important information
## Libraries used for CPU parallelization
| Application | Parallelism | Framework   |
| ----------- | ----------- | ----------- |
| cuda-lane-det | Data-level    | OpenCV (TBB, pthreads) |
| darknet-ros   | Thread-level  | C++ |
| floam         | Thread-level  | C++ | 
| hybrid-astar  | None          | None | 
| jetson-inference  | None      | None | 
| kalman-filter | None          | None | 
| openMVG       | Data-level    | OpenMP | 
| lidar-tracker | Data-level    | OpenCV (TBB, pthreads) | 
| orb-slam-3    | Thread-level  | C++ | 
## Application versions
- jetson-inference @ e4ebc40967604945fd501b8d35ed0b9e86ca8b2d
- floam @ de361346020575bd89d32eac969614bc2c72d17c
- cuda-sfm @ 2e3dcdfeb959426ba897358471f4bee7d9c99b79
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
