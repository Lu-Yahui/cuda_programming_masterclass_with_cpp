xhost +
docker run -it --entrypoint bash --network=host --gpus all --device /dev/dri --rm -e DISPLAY=$DISPLAY -v $HOME/.cache:$HOME/.cache -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:`pwd` cuda_programming_masterclass_with_cpp
