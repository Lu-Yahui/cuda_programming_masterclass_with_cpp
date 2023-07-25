#include <stdio.h>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void HelloCuda() {
  printf("Hello CUDA world\n");
}

int main(int argc, const char* argv[]) {
  HelloCuda<<<1, 1>>>();
  cudaDeviceSynchronize();
  cudaDeviceReset();
  return 0;
}
