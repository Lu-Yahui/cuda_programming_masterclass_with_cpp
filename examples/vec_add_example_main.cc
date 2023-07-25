#include <iostream>

#include "vec_add_example.h"

int main(int argc, const char* argv[]) {
  constexpr int n = 2;
  float* h_A = new float[n];
  float* h_B = new float[n];
  float* h_C = new float[n];
  for (int i = 0; i < n; ++i) {
    h_A[i] = static_cast<float>(i);
    h_B[i] = static_cast<float>(i);
  }

  VecAddGpu(h_A, h_B, h_C, n);

  std::cout << "Size: " << n << std::endl;
  for (int i = 0; i < n; ++i) {
    std::cout << h_A[i] << " + " << h_B[i] << " = " << h_C[i] << std::endl;
  }

  delete[] h_A;
  delete[] h_B;
  delete[] h_C;

  return 0;
}
