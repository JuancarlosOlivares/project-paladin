# Project Paladin 

__Project Paladin__ is an iOS app programmed in Swift that uses Bluetooth services to alert an iOS user when they have left their child/pet unattended in a vehicle.
To do this, pair two Bluetooth devices to an iPhone and track their connection.


## Purpose

The problem this __Project Paladin__ attempts to address is the death of children and pets in locked vehicles due to heat exposure and negligence. According to CNN: “More than 36 kids die in hot cars every year and there’s no clear solution”
Currently automakers are scrambling to find a solution to this problem, as well as some products by different companies.

__Project Paladin__ addresses the issue of high heat exposure in vehicles with minimal error. All products that are currently on the market attempt to solve this problem with either complicated devices or devices with a high error rate. 



## Project Paladin Team
Programmer: Juancarlos Olivares
QA Engineer: Lilibeth Blandon
Software Architect: Logan Serota
Project Manager: Tony Mendoza

## Contributors

## Technical Overview

### How does it work?

Triggers an alert only when a child is left behind in a car. In order to accomplish this, we must keep track of relative locations. The App connects to Bluetooth objects and polls for signal strength. Then it correlates that to distance. An algorithm to determine when a child was likely to have been left behind based on distance.

### Architecture

iOS device for deployment
Mac running Xcode for development
Establishing Bluetooth connectivity with two separate sensors
Maintaining Bluetooth connectivity for periodic RSSI updates
Storage of RSSI data
Correlation of RSSI data to distance from user
Calculation of state {system idle, system armed, child left behind} based on relative distances
Communication of state and distances to user

### Test Plan Details

Debugged code as a result of
App failing to launch, crashing, unresponsive.
Isolated BT connectivity from app functionality to ensure that we could test them separately.
Made sure that the logic was sound in our app design to minimize false positives/negatives.
Tested BT connectivity with various BT devices.


## Installation and configuration

