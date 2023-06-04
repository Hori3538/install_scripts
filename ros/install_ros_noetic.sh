#!/bin/bash

set -e

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
echo "$password" | sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Set up your keys
sudo apt-get install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Installation
sudo apt update
sudo apt install ros-noetic-desktop-full

# Environment setup
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc 
echo "export ROS_WORKSPACE=~/catkin_ws" >> ~/.bashrc 
echo "export ROS_PACKAGE_PATH=~/catkin_ws/src:$ROS_PACKAGE_PATH" >> ~/.bashrc 

# install other packages
sudo apt install python3-osrf-pycommon python3-rosdep python3-catkin-tools

# make catkin_ws
mkdir -p ~/catkin_ws/src
cd catkin_ws
catkin build
