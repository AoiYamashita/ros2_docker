#!/bin/bash -e

#------------- add GPGkey
apt-get install curl gnupg lsb-release -y
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

#------------- add source list in repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

#------------- install ros2
sudo apt update
sudo apt install ros-humble-desktop -y

#------------- setup ros2
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

#------------- install rosdep and init
sudo apt install python3-colcon-common-extensions -y
sudo apt install python3-rosdep -y
sudo rosdep init
rosdep update

#------------- make ws
mkdir -p ~/ros2_ws/src
cd ros2_ws/
colcon build

#------------- install gazebo and rqt
sudo apt -y install gazebo
sudo apt install ros-humble-gazebo-* -y
sudo apt install ros-humble-rqt-* -y

source ~/.bashrc
