#!/bin/bash

# Install dependencies
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run the installer
python main.py

# Finishing
deactivate