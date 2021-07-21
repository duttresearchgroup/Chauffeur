## Essential global packages for running Chauffeur:
- ROS Melodic
- TensorFlow - 1.15 (For LaneNet-Lane-Detection)
- OpenCV (with CUDA) -- 3.4.13
- Eigen3 -- 3.3.9
- Ceres Solver -- 2.0.0


Example instruction for installing TensorFlow 1.15 for Python3.6+JetPack4.4. Source from https://forums.developer.nvidia.com/t/tensorflow-for-jetson-tx2/64596 \
```
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip
sudo pip3 install -U pip
sudo pip3 install -U pip testresources setuptools numpy==1.16.1 future==0.17.1 mock==3.0.5 h5py==2.9.0 keras_preprocessing==1.0.5 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==1.15.4+nv20.12
```

## Application-specific Packages breakdown:
* lane_detection/jetson-lane-detection: `sudo apt-get install libconfig-dev libgsl-dev`
* lane_detection/lanenet-lane-detection: `pip3 install matplotlib tqdm` Tensorflow(check Nvidia's website for more info on Tensorflow for Jetson)
* localization_and_mapping/floam:`apt install ros-melodic-hector-trajectory-server`
* object_detection/darknet-ros:`apt install ros-melodic-cv-bridge ros-melodic-image-transport`
* object_tracking/lidar-tracking:`apt install ros-melodic-pcl-conversions`
* path_planning/hybrid-astar:`apt install ros-melodic-tf ros-melodic-ompl ros-melodic-map-server`
