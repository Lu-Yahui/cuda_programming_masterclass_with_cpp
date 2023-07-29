load("@rules_cuda//cuda:defs.bzl", "cuda_library")

package(default_visibility = ["//visibility:public"])

cuda_library(
    name = "s1_4_vec_add_cu",
    srcs = [
        "s1_4_vec_add.cu"
    ],
)

cc_binary(
    name = "s1_4_vec_add",
    deps = [
        ":s1_4_vec_add_cu"
    ],
)

cuda_library(
    name = "s1_5_hello_cuda_cu",
    srcs = [
        "s1_5_hello_cuda.cu"
    ],
)

cc_binary(
    name = "s1_5_hello_cuda",
    deps = [
        ":s1_5_hello_cuda_cu"
    ],
)

cuda_library(
    name = "s1_6_print_thread_ids_cu",
    srcs = [
        "s1_6_print_thread_ids.cu"
    ],
)

cc_binary(
    name = "s1_6_print_thread_ids",
    deps = [
        ":s1_6_print_thread_ids_cu"
    ],
)

cuda_library(
    name = "s1_7_print_details_cu",
    srcs = [
        "s1_7_print_details.cu"
    ],
)

cc_binary(
    name = "s1_7_print_details",
    deps = [
        ":s1_7_print_details_cu"
    ],
)
