#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive

default_ubuntu_dev_code="focal"
if type lsb_release &> /dev/null
then
    ubuntu_dev_code=$(lsb_release -sc)
else
    ubuntu_dev_code=${default_ubuntu_dev_code}
fi

set_password()
{
    if [ ! ${password} ]
    then
        printf "password: "
        read -s password
    fi
}
set_password

# Setup your sources.list
# echo "$password" | sudo echo "deb http://packages.ros.org/ros/ubuntu ${ubuntu_dev_code} main" > /etc/apt/sources.list.d/ros-latest.list
echo "$password" | sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Set up your keys
sudo apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Installation
sudo apt-get update
sudo apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    ros-noetic-desktop-full

# Environment setup
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc 
echo "export ROS_WORKSPACE=~/catkin_ws" >> ~/.bashrc 
echo "export ROS_PACKAGE_PATH=~/catkin_ws/src:$ROS_PACKAGE_PATH" >> ~/.bashrc 

# install other packages
sudo apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    python3-osrf-pycommon python3-rosdep python3-catkin-tools python3-pip

# make catkin_ws
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
source /opt/ros/noetic/setup.bash
catkin build
source ~/.bashrc
