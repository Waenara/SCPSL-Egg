#!/bin/bash

# Install dependencies
sudo apt-get update -y
sudo apt-get install -y python3 python3-pip
pip3 install -r requirements.txt

# Run the installer
python3 main.py