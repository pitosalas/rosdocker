# Trying to use a working Dockerfile with vnc to now install TB3 stuff
# Added a change based on SO because run apt-key was erroring.
# This is a copy of https://github.com/bpinaya/robond-docker
# This one works and allows me to launch Gazebo
# Launch `docker run --rm -it -p 80:80/tcp rosdocker:latest` will allow you to open a browser on 0.0.0.0
# 

FROM dorowu/ubuntu-desktop-lxde-vnc:xenial

# Update
RUN apt-get update && \
  apt-get upgrade -y

# Install required packages
RUN apt-get install -y \
  dirmngr \
  gnupg \
  tmux \
  curl \
  wget \
  sudo \
  libgl1-mesa-glx \
  libgl1-mesa-dri \
  mesa-utils \
  unzip \
  && rm -rf /var/likb/apt/lists/*

# Adding keys for ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# From Kinetic Installation instructions: http://wiki.ros.org/kinetic/Installation/Ubuntu
RUN sudo apt-get update
RUN apt-get install -y ros-kinetic-desktop-full
RUN rosdep init
RUN rosdep update

