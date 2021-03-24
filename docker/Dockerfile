ARG CUDA_VERSION=10.2
ARG OS_VERSION=18.04
FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${OS_VERSION}

LABEL maintainer = "drg@ics.uci.edu"

# Important reference
# https://github.com/NVIDIA/TensorRT/blob/master/docker/ubuntu-cross-aarch64.Dockerfile
# https://github.com/NVIDIA/DALI/blob/b7d439d5498a426cce0141b2e7389779c47691f1/docker/Dockerfile.build.aarch64-linux

# Use bash as default shell
SHELL ["/bin/bash", "-c"]

# So that no question/dialog is asked during apt-get install:
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    unzip \
    git \
    rsync \
    libjpeg-dev \
    dh-autoreconf \
    pkg-config \
    libtool \
    libtool-bin \
    python3-distutils \
    zip \
    python3.6 python3.6-dev \
    python3.7 python3.7-dev \
    python3.8 python3.8-dev \
    && \
    if [ $(apt-cache search python3.9 | wc -l) -eq 0 ]; then \
        apt-get install software-properties-common -y --no-install-recommends && \
        add-apt-repository ppa:deadsnakes/ppa -y && \
        apt-get update; \
    fi && \
    apt-get install -y python3.9 python3.9-dev && \
    rm -rf /var/lib/apt/lists/* && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py && \
    # decouple libclang and clang installation so libclang changes are not overriden by clang
    pip install clang && pip install libclang && \
    rm -rf /root/.cache/pip/ && \
    cd /tmp && git clone https://github.com/NixOS/patchelf && cd patchelf && \
    ./bootstrap.sh && ./configure --prefix=/usr/ && make -j install && cd / && rm -rf /tmp/patchelf && \
    ln -s /usr/bin/python3 /usr/bin/python

RUN mkdir -p /workspace

# Install cuda-cross compilers
COPY jetpack-files /jetpack-files
RUN dpkg -i /jetpack-files/cuda-repo-cross-aarch64*.deb /jetpack-files/cuda-repo-ubuntu*_amd64.deb \
    && apt-get update \
    && apt-get install -y cuda-cross-aarch64 \
    && rm -rf /var/lib/apt/lists/*

# Unpack cudnn
RUN  dpkg -x /jetpack-files/libcudnn[7-8]_*-1+cuda10.[0-9]_arm64.deb /jetpack-files/cudnn \
    && dpkg -x /jetpack-files/libcudnn[7-8]-dev_*-1+cuda10.[0-9]_arm64.deb /jetpack-files/cudnn

RUN cd /jetpack-files/cudnn/usr/lib/aarch64-linux-gnu \
    && ln -s libcudnn.so.[7-9] libcudnn.so \
    && cd /jetpack-files/cudnn \
    && ln -s usr/include/aarch64-linux-gnu include \
    && ln -s usr/lib/aarch64-linux-gnu lib \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_adv_infer_v[7-9].h /usr/include/cudnn_adv_infer.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_adv_train_v[7-9].h /usr/include/cudnn_adv_train.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_backend_v[7-9].h /usr/include/cudnn_backend.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_cnn_infer_v[7-9].h /usr/include/cudnn_cnn_infer.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_cnn_train_v[7-9].h /usr/include/cudnn_cnn_train.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_ops_infer_v[7-9].h /usr/include/cudnn_ops_infer.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_ops_train_v[7-9].h /usr/include/cudnn_ops_train.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_v[7-9].h /usr/include/cudnn.h \
    && ln -s /jetpack-files/cudnn/usr/include/aarch64-linux-gnu/cudnn_version_v[7-9].h /usr/include/cudnn_version.h


# zlib
RUN LIBZ_VERSION=1.2.11 && \
    cd /tmp && \
    curl -L https://github.com/madler/zlib/archive/v${LIBZ_VERSION}.tar.gz | tar -xzf - && \
    cd zlib-${LIBZ_VERSION} && \
      CFLAGS="-fPIC" \
      CXXFLAGS="-fPIC" \
      CC=aarch64-linux-gnu-gcc \
      CXX=aarch64-linux-gnu-g++ \
    ./configure -prefix=/usr/aarch64-linux-gnu/ && \
    make install -j"$(grep ^processor /proc/cpuinfo | wc -l)" && \
    cd && \
    rm -rf /tmp/zlib-${LIBZ_VERSION}

# CMake
RUN CMAKE_VERSION=3.13 && \
    CMAKE_BUILD=3.13.5 && \
    curl -L https://cmake.org/files/v${CMAKE_VERSION}/cmake-${CMAKE_BUILD}.tar.gz | tar -xzf - && \
    cd /cmake-${CMAKE_BUILD} && \
    ./bootstrap --parallel=$(grep ^processor /proc/cpuinfo | wc -l) && \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install && \
    rm -rf /cmake-${CMAKE_BUILD}

# protobuf
ENV PROTOBUF_VERSION=3.14.0
RUN curl -L https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-all-${PROTOBUF_VERSION}.tar.gz | tar -xzf - && \
    cd /protobuf-${PROTOBUF_VERSION} && \
    ./autogen.sh && \
    ./configure CXXFLAGS="-fPIC" --prefix=/usr/local --disable-shared 2>&1 > /dev/null && \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install 2>&1 > /dev/null

# LMDB
COPY Makefile-lmdb.patch /tmp
RUN LMDB_VERSION=0.9.24 && \
    git clone -b LMDB_${LMDB_VERSION} --single-branch https://github.com/LMDB/lmdb && \
    cd /lmdb/libraries/liblmdb && \
    patch -p3 < /tmp/Makefile-lmdb.patch && \
    rm -f /tmp/Makefile-lmdb.patch && \
      CFLAGS="-fPIC" CXXFLAGS="-fPIC" CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ prefix=/usr/aarch64-linux-gnu \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install && \
    rm -rf /lmdb

RUN cd /protobuf-${PROTOBUF_VERSION} && make clean \
    ./autogen.sh && ./configure \
    CXXFLAGS="-fPIC" \
    CC=aarch64-linux-gnu-gcc \
    CXX=aarch64-linux-gnu-g++ \
      --host=aarch64-unknown-linux-gnu \
      --with-protoc=/usr/local/bin/protoc \
      --prefix=/usr/aarch64-linux-gnu/ && make -j$(nproc) install && \
    rm -rf /protobuf-${PROTOBUF_VERSION}


# libjpeg-turbo
RUN JPEG_TURBO_VERSION=2.0.6 && \
    curl -L https://github.com/libjpeg-turbo/libjpeg-turbo/archive/${JPEG_TURBO_VERSION}.tar.gz | tar -xzf - && \
    cd libjpeg-turbo-${JPEG_TURBO_VERSION} && \
    echo "set(CMAKE_SYSTEM_NAME Linux)" > toolchain.cmake && \
    echo "set(CMAKE_SYSTEM_PROCESSOR aarch64)" >> toolchain.cmake && \
    echo "set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc)" >> toolchain.cmake && \
      CFLAGS="-fPIC" \
      CXXFLAGS="-fPIC" \
      CC=aarch64-linux-gnu-gcc \
      CXX=aarch64-linux-gnu-g++ \
    cmake -G"Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake -DENABLE_SHARED=TRUE -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu/ . 2>&1 >/dev/null && \
      CFLAGS="-fPIC" \
      CXXFLAGS="-fPIC" \
      CC=aarch64-linux-gnu-gcc \
      CXX=aarch64-linux-gnu-g++ \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install 2>&1 >/dev/null && \
    rm -rf /libjpeg-turbo-${JPEG_TURBO_VERSION}

# zstandard compression library
RUN ZSTANDARD_VERSION=1.4.5 && \
    curl -L https://github.com/facebook/zstd/releases/download/v${ZSTANDARD_VERSION}/zstd-${ZSTANDARD_VERSION}.tar.gz | tar -xzf - && \
    cd zstd-${ZSTANDARD_VERSION} && \
      CFLAGS="-fPIC" CXXFLAGS="-fPIC" CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ prefix=/usr/aarch64-linux-gnu \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install 2>&1 >/dev/null && \
    rm -rf /zstd-${ZSTANDARD_VERSION}

# libtiff
RUN LIBTIFF_VERSION=4.1.0 && \
    cd /tmp && \
    curl -L http://download.osgeo.org/libtiff/tiff-${LIBTIFF_VERSION}.tar.gz | tar -xzf - && \
    cd tiff-${LIBTIFF_VERSION} && \
    ./autogen.sh && \
    ./configure \
      CFLAGS="-fPIC" \
      CXXFLAGS="-fPIC" \
      CC=aarch64-linux-gnu-gcc \
      CXX=aarch64-linux-gnu-g++ \
      --host=aarch64-unknown-linux-gnu \
      --prefix=/usr/aarch64-linux-gnu/ \
      --with-zstd-include-dir=/usr/aarch64-linux-gnu/include \
      --with-zstd-lib-dir=/usr/aarch64-linux-gnu/lib         \
      --with-zlib-include-dir=/usr/aarch64-linux-gnu/include \
      --with-zlib-lib-dir=/usr/aarch64-linux-gnu/lib      && \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" && \
    make install && \
    cd && \
    rm -rf /tmp/tiff-${LIBTIFF_VERSION}

# OpenJPEG
RUN OPENJPEG_VERSION=2.3.1 && \
    cd /tmp && \
    curl -L https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz | tar -xzf - && \
    cd openjpeg-${OPENJPEG_VERSION} && mkdir build && cd build && \
    echo "set(CMAKE_SYSTEM_NAME  Linux)" > toolchain.cmake && \
    echo "set(CMAKE_SYSTEM_PROCESSOR aarch64)" >> toolchain.cmake && \
    echo "set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc)" >> toolchain.cmake && \
      CFLAGS="-fPIC" \
      CXXFLAGS="-fPIC" \
      CC=aarch64-linux-gnu-gcc \
      CXX=aarch64-linux-gnu-g++ \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake -DBUILD_CODEC=OFF \
          -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu/ .. && \
      CFLAGS="-fPIC" \
      CXXFLAGS="-fPIC" \
      CC=aarch64-linux-gnu-gcc \
      CXX=aarch64-linux-gnu-g++ \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install && \
    rm -rf openjpeg-${OPENJPEG_VERSION}

# OpenCV
RUN OPENCV_VERSION=4.5.0 && \
    curl -L https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz | tar -xzf - && \
    cd /opencv-${OPENCV_VERSION} && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_TOOLCHAIN_FILE=$PWD/../platforms/linux/aarch64-gnu.toolchain.cmake \
          -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu/ \
          -DBUILD_SHARED_LIBS=OFF \
          -DBUILD_LIST=core,improc,imgcodecs \
          -DBUILD_PNG=ON \
          -DBUILD_TIFF=OFF \
          -DBUILD_TBB=OFF \
          -DBUILD_WEBP=OFF \
          -DBUILD_JPEG=OFF \
          -DBUILD_TIFF=OFF \
          -DWITH_JPEG=ON \
          -DWITH_TIFF=ON \
          -DBUILD_JASPER=OFF \
          -DBUILD_ZLIB=ON \
          -DBUILD_EXAMPLES=OFF \
          -DBUILD_opencv_java=OFF \
          -DBUILD_opencv_python2=OFF \
          -DBUILD_opencv_python3=OFF \
          -DENABLE_NEON=OFF \
          -DWITH_PROTOBUF=OFF \
          -DWITH_PTHREADS_PF=OFF \
          -DWITH_OPENCL=OFF \
          -DWITH_OPENMP=OFF \
          -DWITH_FFMPEG=OFF \
          -DWITH_GSTREAMER=OFF \
          -DWITH_GSTREAMER_0_10=OFF \
          -DWITH_CUDA=OFF \
          -DWITH_GTK=OFF \
          -DWITH_VTK=OFF \
          -DWITH_TBB=OFF \
          -DWITH_1394=OFF \
          -DWITH_OPENEXR=OFF \
          -DINSTALL_C_EXAMPLES=OFF \
          -DINSTALL_TESTS=OFF \
          -DVIBRANTE=TRUE \
          VERBOSE=1 ../ && \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" install && \
    rm -rf /opencv-${OPENCV_VERSION}

ENV PKG_CONFIG_PATH=/usr/aarch64-linux-gnu/lib/pkgconfig

# libgsl (GNU Scientific library)
WORKDIR /tmp
RUN curl -L ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz -O
RUN tar -xf gsl-2.6.tar.gz
WORKDIR gsl-2.6
RUN ./configure \
      CFLAGS="-fPIC" \
      CXXFLAGS="-fPIC" \
      CC=aarch64-linux-gnu-gcc \
      CXX=aarch64-linux-gnu-g++ \
      --host=aarch64-unknown-linux-gnu \
      --prefix=/usr/aarch64-linux-gnu/ && \
    make -j"$(grep ^processor /proc/cpuinfo | wc -l)" && \
    make install

WORKDIR /workspace

CMD [ "bash", "/workspace/build.sh" ]