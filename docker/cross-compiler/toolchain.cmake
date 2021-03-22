set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          aarch64)

# Without that flag CMake is not able to pass test compilation check
# set(CMAKE_TRY_COMPILE_TARGET_TYPE   STATIC_LIBRARY)

set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)

set(NVIDIA_TOOLCHAIN_PATH           "/workspace/cross-compiler/")

set(CMAKE_AR                        ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-ar${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_ASM_COMPILER              ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-gcc${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_C_COMPILER                ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-gcc${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_CXX_COMPILER              ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-g++${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_LINKER                    ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-ld${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_OBJCOPY                   ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-objcopy${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_RANLIB                    ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-ranlib${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_SIZE                      ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-size${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_STRIP                     ${NVIDIA_TOOLCHAIN_PATH}bin/aarch64-linux-gnu-strip${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")

set(CMAKE_C_FLAGS                   "" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS                 "${CMAKE_C_FLAGS} " CACHE INTERNAL "")

set(CMAKE_C_FLAGS_DEBUG             "-Os -g" CACHE INTERNAL "")
set(CMAKE_C_FLAGS_RELEASE           "-Os -DNDEBUG" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_DEBUG           "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_RELEASE         "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


# set(TARGET_SUPPORTS_SHARED_LIBS TRUE)
# CUDA librares
set(CUDA_TOOLKIT_ROOT_DIR           "/usr/local/cuda/targets/aarch64-linux/")
set(CUDA_TOOLKIT_INCLUDE            "/usr/local/cuda/targets/aarch64-linux/include")
set(CUDA_CUDART_LIBRARY             "/usr/local/cuda/targets/aarch64-linux/lib/libcudart.so")
set(CUDA_nppicc_LIBRARY             "/usr/local/cuda/targets/aarch64-linux/lib/libnppicc.so")