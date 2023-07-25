load("@rules_cuda//cuda:defs.bzl", "cuda_library")

package(default_visibility = ["//visibility:public"])

cuda_library(
    name = "s1_4_vec_add",
    srcs = [
        "s1_4_vec_add.cu"
    ],
)

cc_binary(
    name = "s1_4_vec_add_main",
    deps = [
        ":s1_4_vec_add"
    ],
)

