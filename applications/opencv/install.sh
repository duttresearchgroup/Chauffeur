# /bin/bash

export PATH=$NVIDIA_TOOLCHAIN_PATH/bin:$PATH
export CROSS_COMPILE=aarch64-linux-gnu-

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_PNG=OFF \
    -DBUILD_TIFF=OFF \
    -DBUILD_TBB=OFF \
    -DBUILD_JPEG=OFF \
    -DBUILD_JASPER=ON \
    -DBUILD_ZLIB=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_JAVA=OFF \
    -DBUILD_opencv_python2=ON \
    -DBUILD_opencv_python3=OFF \
    -DENABLE_PRECOMPILED_HEADERS=OFF \
    -DWITH_OPENCL=OFF \
    -DWITH_OPENMP=OFF \
    -DWITH_FFMPEG=ON \
    -DWITH_GSTREAMER=OFF \
    -DWITH_GSTREAMER_0_10=OFF \
    -DWITH_CUDA=ON \
    -DWITH_GTK=ON \
    -DWITH_VTK=OFF \
    -DWITH_TBB=ON \
    -DWITH_1394=OFF \
    -DWITH_OPENEXR=OFF \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda/targets/aarch64-linux/ \
    -DCUDA_ARCH_BIN=10.0 \
    -DCUDA_ARCH_PTX="" \
    -DINSTALL_C_EXAMPLES=OFF \
    -DINSTALL_TESTS=OFF \
    -DOPENCV_TEST_DATA_PATH=../opencv_extra/testdata \
    -DCMAKE_TOOLCHAIN_FILE=$NVIDIA_TOOLCHAIN_PATH/toolchain.cmake \
    ../../opencv-3.4.13/