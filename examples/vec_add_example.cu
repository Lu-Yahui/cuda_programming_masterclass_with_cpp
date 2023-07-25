#include <cmath>

#include "vec_add_example.h"

__global__ void VecAddKernel(float* A, float* B, float* C, int n) {
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  if (i < n) {
    C[i] = A[i] + B[i];
  }
}

void VecAddGpu(float* h_A, float* h_B, float* h_C, int n) {
  int size = n * sizeof(float);

  float* d_A;
  float* d_B;
  float* d_C;
  cudaMalloc((void**)&d_A, size);
  cudaMalloc((void**)&d_B, size);
  cudaMalloc((void**)&d_C, size);

  cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

  int block_size = static_cast<int>(std::ceil(n / 256.0));
  dim3 dim_grid(block_size, 1, 1);
  dim3 dim_block(256, 1, 1);
  VecAddKernel<<<dim_grid, dim_block>>>(d_A, d_B, d_C, n);

  cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);

  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);
}
