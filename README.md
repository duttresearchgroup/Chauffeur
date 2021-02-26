# biton
Benchmark suite for embedded autonomous vehicle application

What we have:
Structure-From-Mothion  =>  OpenMVG
Object Detection:       =>  Jetson-Inference(Hello_Ai_World)
Lane Detection:         =>  Jetson TX2 Lane Detection

Essential dependencies version on Hydra:
Eigen3 -- 3.3.9
Ceres Solver -- 2.0.0

For run application on sample inputs as quick start:

OpenMVG: 
$ cd openMVG_Build/software/SfM/


$ python SfM_GlobalPipeline.py [full path image directory] [resulting directory]          


$ python SfM_GlobalPipeline.py ~/home/user/data/ImageDataset_SceauxCastle/images ~/home/user/data/ImageDataset_SceauxCastle/Castle_Global_Reconstruction


The asscociate Image_dataset is under the openMVG folder.



Jetson-Inference:


First you will need to build the project following the instruction on Dusty's website.


There're two way to build it:


Running the Docker Container  --  https://github.com/dusty-nv/jetson-inference/blob/master/docs/aux-docker.md


Building the Project from Source  --  https://github.com/dusty-nv/jetson-inference/blob/master/docs/building-repo-2.md


I build the project from source for Hydra.


Then to run Classifying Images with ImageNet:



$ cd jetson-inference/build/aarch64/bin


To run C++ sample program:


$ ./imagenet images/orange_0.jpg images/test/output_0.jpg     # (default network is googlenet)


To run Python sample program:


$ ./imagenet.py images/orange_0.jpg images/test/output_0.jpg  # (default network is googlenet)



If you met "failed to open swrast" issue, you could try link the libdrm.so.2 to libdrm.so.2.4.0 (Thank you Hans!)


$ cd /usr/lib/aarch64-linux-gnu


$ sudo ln -sf libdrm.so.2.4.0 libdrm.so.2



Except for object detection, Jetson-Inference have more features like Locating and Semantic Segmentation in the future that we might need to work with.



Jetson TX2 Lane Detection:


To build the application, we first need to modify two functions in src/detector.cpp since the updated OpenCV version:

In src/detector.cpp 	


line 51: 	CV_FOURCC('M', 'P', 'E', 'G') -> cv::VideoWriter::fourcc('M', 'P', 'E', 'G')


Line 284:	CV_BGR2GRAY -> cv::COLOR_BGR2GRAY


Then we will need to install the dependencies and then build:


$./install_dependencies.sh


$./build.sh


$./build.sh clean


Then after building the application, we can run the sample with the run.sh we wrote.











Authors of OpenMVG:
Pierre Moulon <pmoulon@gmail.com>
Pascal Monasse <monasse@imagine.enpc.fr>
Renaud Marlet <renaud.marlet@enpc.fr>

anhtuann
Bruno Duisit
Fabien Castan
Iivari Äikäs
luxigo
Michael Holroyd
Romain Janvier
Rory McCann
Romuald Perrot
rhiestan
sergi pujades-rocamora
sflotron
vincentweb
Yohann Salaun




Author of Jetson-inference:
Nvidia




Author of Jetson TX2 Lane Detection:
@jaredraycoleman 


@tainagdcoleman


@antwonn


@fieryWaters

