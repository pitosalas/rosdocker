# Seem to do everything, except being able to launch graphical apps or run over VNC

FROM ubuntu:16.04
RUN apt-get update && apt-get install --assume-yes wget sudo

# create non-root user
ENV USERNAME ros
RUN adduser --ingroup sudo --disabled-password --gecos "" --shell /bin/bash --home /home/$USERNAME $USERNAME
RUN bash -c 'echo $USERNAME:ros | chpasswd'
ENV HOME /home/$USERNAME
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $USERNAME:sudo
RUN echo `whoami`
RUN echo `pwd`
WORKDIR /home/$USERNAME

RUN sudo apt-get -y update && sudo apt-get -y upgrade
RUN wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_kinetic.sh && \
chmod 755 ./install_ros_kinetic.sh && \
bash ./install_ros_kinetic.sh

RUN sudo apt-get install --assume-yes ros-kinetic-joy ros-kinetic-teleop-twist-joy ros-kinetic-teleop-twist-keyboard
RUN sudo apt-get install -y ros-kinetic-teleop-twist-joy ros-kinetic-teleop-twist-keyboard ros-kinetic-laser-proc ros-kinetic-rgbd-launch 
RUN sudo apt-get install -y ros-kinetic-depthimage-to-laserscan ros-kinetic-rosserial-arduino ros-kinetic-rosserial-python 
RUN sudo apt-get install -y ros-kinetic-rosserial-server ros-kinetic-rosserial-client ros-kinetic-rosserial-msgs ros-kinetic-amcl 
RUN sudo apt-get install -y ros-kinetic-map-server ros-kinetic-move-base ros-kinetic-urdf ros-kinetic-xacro ros-kinetic-compressed-image-transport 
RUN sudo apt-get install -y ros-kinetic-rqt-image-view ros-kinetic-gmapping ros-kinetic-navigation ros-kinetic-interactive-markers

RUN echo `pwd`
RUN echo `ls -la`
WORKDIR /home/$USERNAME

RUN cd /home/$USERNAME/catkin_ws/src/ && \
  git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git && \
  git clone https://github.com/ROBOTIS-GIT/turtlebot3.git && \
  git clone https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git


RUN echo 'source /opt/ros/kinetic/setup.bash' >> /home/$USERNAME/.bashrc
RUN echo 'source /home/ros/catkin_ws/devel/setup.bash' >> /home/$USERNAME/.bashrc
RUN echo `pwd`
RUN echo `cat /home/ros/.bashrc`
RUN echo `ls  -la /home/ros/.bashrc`
RUN /bin/bash -c "source /home/$USERNAME/.bashrc"

