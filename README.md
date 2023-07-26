# CUDA Programming Masterclass with C++
## Env Setup
1. Build Docker
```bash
bash build_docker.sh
```
2. Run Docker
```bash
bash run_docker.sh
```
3. Verify env setup by
```bash
# vector addition
bazel run //examples:vec_add_example_main
```
```bash
# print out GPU device property
bazel run //examples:device_property_example_main
```
```bash
# thrust example
bazel run //examples:thrust_example_main
```
---
## Section 1: Introduction to CUDA Programming and CUDA Programming Model
1. s1_4: vec add kernel
2. s1_5: hello cuda
3. s1_6: print thread IDs
