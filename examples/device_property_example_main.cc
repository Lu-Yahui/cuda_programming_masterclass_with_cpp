#include <iostream>

#include "cuda_runtime.h"

int main(int argc, const char* argv[]) {
  int dev_count;
  cudaGetDeviceCount(&dev_count);
  std::cout << "Device count: " << dev_count << std::endl;

  for (int i = 0; i < dev_count; ++i) {
    cudaDeviceProp dev_prop;
    cudaGetDeviceProperties(&dev_prop, i);

    std::cout << "### Device " << i << " ###" << std::endl;
    std::cout << "- L2 cache size: " << dev_prop.l2CacheSize << std::endl;
    std::cout << "- shared mem per block: " << dev_prop.sharedMemPerBlock << std::endl;
    std::cout << "- streaming multiprocessor count: " << dev_prop.multiProcessorCount << std::endl;
    std::cout << "- clock rate: " << dev_prop.clockRate << std::endl;
    std::cout << "- max thread dim(x, y, z): (" << dev_prop.maxThreadsDim[0] << ", " << dev_prop.maxThreadsDim[1]
              << ", " << dev_prop.maxThreadsDim[2] << ")" << std::endl;
    std::cout << "- max threads per block: " << dev_prop.maxThreadsPerBlock << std::endl;
    std::cout << "- max grid size(x, y, z): (" << dev_prop.maxGridSize[0] << ", " << dev_prop.maxGridSize[1] << ", "
              << dev_prop.maxGridSize[2] << ")" << std::endl;
    std::cout << "- wrap size: " << dev_prop.warpSize << std::endl;
    std::cout << "- total const mem: " << dev_prop.totalConstMem << std::endl;
    std::cout << "..." << std::endl;
  }

  return 0;
}
