#!/bin/bash

set -e

# Setup your sources.list
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Set up your keys
apt-get install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# Installation
apt update
apt install ros-noetic-desktop-full

# Environment setup
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc 
echo "export ROS_WORKSPACE=~/catkin_ws" >> ~/.bashrc 
echo "export ROS_PACKAGE_PATH=~/catkin_ws/src:$ROS_PACKAGE_PATH" >> ~/.bashrc 
source ~/.bashrc

# install other packages
apt install python3-osrf-pycommon python3-rosdep python3-catkin-tools

# make catkin_ws
mkdir -p ~/catkin_ws/src
cd catkin_ws
catkin build
