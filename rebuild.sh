#!/usr/bin/env bash

set -e

WS="$HOME/development/ros/gem_cutter_manipulator"  #change this to your cloned path

echo ">>> Cleaning build, install, log in $WS"
rm -rf "$WS/build" "$WS/install" "$WS/log"

echo ">>> Sourcing base ROS (Jazzy)"
source /opt/ros/jazzy/setup.bash

echo ">>> Building workspace (symlink install)"
cd "$WS"
colcon build --symlink-install

echo ">>> Sourcing workspace overlay"
source "$WS/install/setup.bash"

echo ">>> Setting Gazebo resource path from gem_cutter_description"
PREFIX=$(ros2 pkg prefix gem_cutter_description)
export GZ_SIM_RESOURCE_PATH="${GZ_SIM_RESOURCE_PATH:+$GZ_SIM_RESOURCE_PATH:}$PREFIX/share"

echo ">>> GZ_SIM_RESOURCE_PATH:"
echo "$GZ_SIM_RESOURCE_PATH"

echo ">>> Done. Current dir: $WS"
