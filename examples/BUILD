load("@rules_cuda//cuda:defs.bzl", "cuda_library")

package(default_visibility = ["//visibility:public"])

# vec add example
cuda_library(
    name = "vec_add_example",
    srcs = ["vec_add_example.cu"],
    hdrs = ["vec_add_example.h"],
)

cc_binary(
    name = "vec_add_example_main",
    srcs = ["vec_add_example_main.cc"],
    deps = [
        ":vec_add_example",
    ],
)

# device property example
cc_binary(
    name = "device_property_example_main",
    srcs = ["device_property_example_main.cc"],
    deps = [
        "@local_cuda//:cuda_runtime"
    ],
)

# thrust example
cuda_library(
    name = "thrust_example",
    srcs = [
        "thrust_example.cu"
    ],
    deps = [
        "@local_cuda//:thrust"
    ],
)

cc_binary(
    name = "thrust_example_main",
    deps = [
        ":thrust_example"
    ],
)