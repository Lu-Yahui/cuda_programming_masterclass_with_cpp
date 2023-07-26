#include <stdio.h>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void PrintThreadIDs() {
  printf("thread.x: %d, thread.y: %d, thread.z: %d\n", threadIdx.x, threadIdx.y, threadIdx.z);
}

int main(int argc, const char* argv[]) {
  int nx = 16;
  int ny = 16;

  dim3 block(8, 8);
  dim3 grid(nx / 8, ny / 8);
  PrintThreadIDs<<<grid, block>>>();

  cudaDeviceSynchronize();
  cudaDeviceReset();
  return 0;
}