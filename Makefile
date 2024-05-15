SHELL := /bin/bash
.PHONY: clean build submodules deps rviz rqt run-openmower run-sim

submodules:
	git submodule init
	git submodule update

deps: submodules
	sudo apt update
	rosdep update
	rosdep install --from-paths src --ignore-src --default-yes

build:
	catkin_make_isolated

clean:
	rm -Rf build* devel*

rviz:
	export ROS_MASTER_URI=http://127.0.0.1:11311 &&	rviz

rqt:
	export ROS_MASTER_URI=http://127.0.0.1:11311 &&	rqt

run-openmower:
	export ROS_MASTER_URI=http://127.0.0.1:11311 &&	source devel_isolated/setup.bash &&	source .devcontainer/mower_config.sh &&	roslaunch open_mower open_mower.launch

run-sim:
	export ROS_MASTER_URI=http://127.0.0.1:11311 && source devel_isolated/setup.bash &&	source .devcontainer/mower_config.sh &&	roslaunch open_mower sim_mower_logic.launch
