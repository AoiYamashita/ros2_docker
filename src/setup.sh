#!/bin/bash -e

#------------- add GPGkey
apt-get install curl gnupg lsb-release -y
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

#------------- add source list in repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

#------------- install ros2
apt update
apt install ros-humble-desktop -y

#------------- setup ros2
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

#------------- install rosdep and init
apt install python3-colcon-common-extensions -y
apt install python3-rosdep -y
rosdep init
rosdep update

#------------- make ws
mkdir -p ~/ros2_ws/src
cd ros2_ws/
colcon build

#------------- install gazebo and rqt
apt -y install gazebo
apt install ros-humble-gazebo-* -y
apt install ros-humble-rqt-* -y

source ~/.bashrc
