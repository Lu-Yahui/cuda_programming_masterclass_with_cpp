#include <stdio.h>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void PrintDetails() {
  printf(
      "blockIdx.x %d, blockIdx.y %d, blockIdx.z %d, blockDim.x %d blockDim.y %d, blockDim.z %d, gridDim.x %d gridDim.y "
      "%d, gridDim.y %d\n",
      blockIdx.x, blockIdx.y, blockIdx.z, blockDim.x, blockDim.y, blockDim.z, gridDim.x, gridDim.y, gridDim.z);
}

int main(int argc, const char* argv[]) {
  int nx = 16;
  int ny = 16;
  dim3 block(8, 8);
  dim3 grid(nx / 8, ny / 8);
  PrintDetails<<<grid, block>>>();
  cudaDeviceSynchronize();
  cudaDeviceReset();
  return 0;
}