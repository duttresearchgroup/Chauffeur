# Important reference
# https://docs.nvidia.com/vpi/sample_cross_aarch64.html

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# Without that flag CMake is not able to pass test compilation check
# set(CMAKE_TRY_COMPILE_TARGET_TYPE   STATIC_LIBRARY)

# set(NVIDIA_TOOLCHAIN_PATH           "/workspace/cross-compiler/")

# set(CMAKE_AR                        ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-ar${CMAKE_EXECUTABLE_SUFFIX})
# set(CMAKE_ASM_COMPILER              ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-gcc${CMAKE_EXECUTABLE_SUFFIX})
# set(CMAKE_C_COMPILER                ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-gcc${CMAKE_EXECUTABLE_SUFFIX})
# set(CMAKE_CXX_COMPILER              ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-g++${CMAKE_EXECUTABLE_SUFFIX})
# set(CMAKE_LINKER                    ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-ld${CMAKE_EXECUTABLE_SUFFIX})
# set(CMAKE_OBJCOPY                   ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-objcopy${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
# set(CMAKE_RANLIB                    ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-ranlib${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
# set(CMAKE_SIZE                      ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-size${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
# set(CMAKE_STRIP                     ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-strip${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")

# set(CMAKE_C_FLAGS                   "" CACHE INTERNAL "")
# set(CMAKE_CXX_FLAGS                 "${CMAKE_C_FLAGS} " CACHE INTERNAL "")

# set(CMAKE_C_FLAGS_DEBUG             "-Os -g" CACHE INTERNAL "")
# set(CMAKE_C_FLAGS_RELEASE           "-Os -DNDEBUG" CACHE INTERNAL "")
# set(CMAKE_CXX_FLAGS_DEBUG           "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
# set(CMAKE_CXX_FLAGS_RELEASE         "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")

# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


# # set(TARGET_SUPPORTS_SHARED_LIBS TRUE)
# # CUDA librares
# set(CMAKE_CUDA_COMPILER_WORKS TRUE)
# set(CMAKE_CUDA_FLAGS                "TARGET_ARCH=aarch64 TARGET_OS=linux")


set(target_arch aarch64-linux-gnu)
set(CMAKE_LIBRARY_ARCHITECTURE ${target_arch} CACHE STRING "" FORCE)
 
# Configure cmake to look for libraries, include directories and
# packages inside the target root prefix.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_FIND_ROOT_PATH "/usr/${target_arch}")
 
# needed to avoid doing some more strict compiler checks that
# are failing when cross-compiling
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
 
# specify the toolchain programs
find_program(CMAKE_C_COMPILER ${target_arch}-gcc)
find_program(CMAKE_CXX_COMPILER ${target_arch}-g++)
if(NOT CMAKE_C_COMPILER OR NOT CMAKE_CXX_COMPILER)
    message(FATAL_ERROR "Can't find suitable C/C++ cross compiler for ${target_arch}")
endif()
 
set(CMAKE_C_FLAGS                   "-fPIC" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS                 "${CMAKE_C_FLAGS} " CACHE INTERNAL "")


set(CMAKE_AR ${target_arch}-ar CACHE FILEPATH "" FORCE)
set(CMAKE_RANLIB ${target_arch}-ranlib)
set(CMAKE_LINKER ${target_arch}-ld)
 
# Not all shared libraries dependencies are instaled in host machine.
# Make sure linker doesn't complain.
set(CMAKE_EXE_LINKER_FLAGS_INIT -Wl,--allow-shlib-undefined)
 
# instruct nvcc to use our cross-compiler
set(CMAKE_CUDA_FLAGS "-ccbin ${CMAKE_CXX_COMPILER} -Xcompiler -fPIC" CACHE STRING "" FORCE)

# CUDA 
set(CUDA_TOOLKIT_ROOT_DIR           "/usr/local/cuda/targets/aarch64-linux/")
set(CUDA_TOOLKIT_INCLUDE            "/usr/local/cuda/targets/aarch64-linux/include")
set(CUDA_CUDART_LIBRARY             "/usr/local/cuda/targets/aarch64-linux/lib/libcudart.so")
set(CUDA_nppicc_LIBRARY             "/usr/local/cuda/targets/aarch64-linux/lib/stubs/libnppicc.so")

# Set CUDNN paths
set(CUDNN_LIBRARY                  "/jetpack-files/cudnn/lib/libcudnn.so")
set(CUDNN_INCLUDE_DIR              "/jetpack-files/cudnn/include")