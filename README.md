# Chauffeur: Benchmark Suite for Design and End-to-End Analysis of Self-Driving Vehicles on Embedded Systems

# Citation
If you use this work, please cite our paper published in ESWEEK-TECS special issue and presented in the International Conference on Hardware/Software Codesign and System Synthesis (CODES+ISSS), 2021.

> B.  Maity,  S.  Yi,  D.  Seo,  L.  Cheng,  S. S.  Lim,  J. C.  Kim,  B.  Donyanavard,  and  N.  Dutt, "Chauffeur:  Benchmark  suite  for  design  and  end-to-end  analysis  of  self-driving  vehicles  onembedded systems," ACM Transactions on Embedded Computing Systems (TECS), Oct. 2021.


# Step 0: Download Chauffeur :)
```
git clone https://github.com/duttresearchgroup/Chauffeur
cd Chauffeur
git submodule update --init --recursive
```
# Step 1 Compilation
## 1.a (Cross)  using qemu based docker
We are using dockers to compile the source code of the micro-benchmarks. Please navigate to the `docker` folder and perform the following steps:

### Setting up docker
* follow instructions [here](https://docs.docker.com/engine/install/ubuntu/) to make sure docker is installed

### Setting up qemu based cross-compiler env
*  For Linux(debian):<br />
`# Install the qemu packages`<br />
`sudo apt-get install qemu binfmt-support qemu-user-static`
*  For Macos<br />
`brew install qemu`
### Next steps
* `docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts`
* Pleaser refer [to this link](https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/) for more details. 

### Getting the virtual Linux4Tegra (L4T) ready
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

## 1.b Compilation on the board
```
source scripts/envs.sh
bash scripts/APP_NAME/build.sh [tx2/px2>] 
(e.g., bash scripts/darknet_ros/build.sh tx2)
```

See the [wiki](https://github.com/duttresearchgroup/Chauffeur/wiki) for more information.
# Step 2: Deployment from host onto target board
* This step is only required if you are cross-compiling Chauffeur
* Please ensure that `rsync` is installed in both host and target, and additionally `sshpass` is installed on host. 
* In `scripts/envs.sh` modify the remote credentials where you want to deploy. 
* Create a file called `scripts/passwd` to store the ssh password.
* Next using `bash` shell execute the following:
```
scripts/send.sh cross-apps/ applications/
scripts/send.sh scripts/ scripts/
scripts/send.sh data/ data/
```
# Step 3: Running on board
* `source scripts/envs.sh`
* In `scripts` folder we have include the relevant launching script `run.sh` for each application. For example, to run application kalman_filter, `sh scripts/kalman_filter/run.sh`
* For cross compiled environment, pass `cross` as an argument to the file. Example:  `sh scripts/kalman_filter/run.sh cross`.
* Be careful about running multiple instances of the same app. Only one instance of each app should be running at a time. Use `sudo kill` to end a previous instance of an app before running a new one.
### Extra Note:
For cross-compiling, we also installed the following libraries on the target with the provided packages folder:
* `cd Chauffeur`
* `pip3 install -r packages/requirements.txt`
* `sudo apt-get update`
* `xargs sudo apt-get install <packages/apt_requirements.txt`

More information for required packages can be found [here](packages/breakdown.md).
# End-to-end evaluation
For running instances of the end-to-end pipeline consisting of Chauffeur applications, we support a python based script. 
* `cd Chauffeur/scripts/end-to-end`
* `pip3 install -r requirements.txt`
* `python3 runner.py`
 
Now, the runner is ready for accepting inputs from the user.
Users can select workloads by typing ctrl+c and then followed either by a number(0-8) for selecting the workload, or the character 'a' for launching.

# Other important information
## Supported platforms
- **NVIDIA Jetson TX2** : Tested with Jetpack 4.2.1, L4T 32.2.0]
- **NVIDIA Drive PX2** : No cross-compiler support, Tested with NVIDIA DRIVE OS 4.9.80-rt61-tegra
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
