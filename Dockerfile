# This is an auto generated Dockerfile for ros:ros-base
# generated from docker_images/create_ros_image.Dockerfile.em
FROM ros:melodic-ros-core-bionic

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-melodic-desktop-full=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

# Install additional tools etc
# install helpful developer tools
RUN apt-get update && apt-get install -y \
      bash-completion \
      byobu \
      fish \
      glances \
      nano \
      python3-argcomplete \
      tree \
      vim \
    && cd /usr/bin && curl https://getmic.ro | bash \
    && rm -rf /var/lib/apt/lists/*

# install turtlebot external packages
RUN apt-get update && apt-get install -y \
      ros-$ROS_DISTRO-rqt* \
      ros-$ROS_DISTRO-turtlebot3-simulations \
      ros-$ROS_DISTRO-turtlebot3-teleop \
    && rm -rf /var/lib/apt/lists/*