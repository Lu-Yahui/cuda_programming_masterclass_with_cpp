#include <stdio.h>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void AddKernel(int* c, const int* a, const int* b) {
  int i = threadIdx.x;
  c[i] = a[i] + b[i];
}

cudaError_t AddWithCuda(int* c, const int* a, const int* b, unsigned int size) {
  int* d_a;
  int* d_b;
  int* d_c;

  cudaError_t cuda_status;

  // Choose which GPU to run on, change this on a multi-GPU system.
  cuda_status = cudaSetDevice(0);
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaSetDevice failed!  Do you have a CUDA-capable GPU installed?");
    goto Error;
  }

  // Allocate GPU buffers for three vectors (two input, one output).
  cuda_status = cudaMalloc((void**)&d_c, size * sizeof(int));
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaMalloc failed!");
    goto Error;
  }

  cuda_status = cudaMalloc((void**)&d_a, size * sizeof(int));
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaMalloc failed!");
    goto Error;
  }

  cuda_status = cudaMalloc((void**)&d_b, size * sizeof(int));
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaMalloc failed!");
    goto Error;
  }

  // Copy input vectors from host memory to GPU buffers.
  cuda_status = cudaMemcpy(d_a, a, size * sizeof(int), cudaMemcpyHostToDevice);
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaMemcpy failed!");
    goto Error;
  }

  cuda_status = cudaMemcpy(d_b, b, size * sizeof(int), cudaMemcpyHostToDevice);
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaMemcpy failed!");
    goto Error;
  }

  // Launch a kernel on the GPU with one thread for each element.
  AddKernel<<<1, size>>>(d_c, d_a, d_b);
  cuda_status = cudaGetLastError();
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "addKernel launch failed: %s\n", cudaGetErrorString(cuda_status));
    goto Error;
  }

  // cudaDeviceSynchronize waits for the kernel to finish, and returns
  // any errors encountered during the launch.
  cuda_status = cudaDeviceSynchronize();
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaDeviceSynchronize returned error code %d after launching addKernel!\n", cuda_status);
    goto Error;
  }

  // Copy output vector from GPU buffer to host memory.
  cuda_status = cudaMemcpy(c, d_c, size * sizeof(int), cudaMemcpyDeviceToHost);
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaMemcpy failed!");
    goto Error;
  }

Error:
  cudaFree(d_c);
  cudaFree(d_a);
  cudaFree(d_b);

  return cuda_status;
}

int main(int argc, const char* argv[]) {
  const int array_size = 5;
  const int a[array_size] = {1, 2, 3, 4, 5};
  const int b[array_size] = {10, 20, 30, 40, 50};
  int c[array_size];

  cudaError_t cuda_status = AddWithCuda(c, a, b, array_size);
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "addWithCuda failed!");
    return 1;
  }

  printf("{1,2,3,4,5} + {10,20,30,40,50} = {%d,%d,%d,%d,%d}\n", c[0], c[1], c[2], c[3], c[4]);

  // cudaDeviceReset must be called before exiting in order for profiling and
  // tracing tools such as Nsight and Visual Profiler to show complete traces.
  cuda_status = cudaDeviceReset();
  if (cuda_status != cudaSuccess) {
    fprintf(stderr, "cudaDeviceReset failed!");
    return 1;
  }

  return 0;
}