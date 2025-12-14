#!/bin/bash

# MeshCore Network Simulator - Run Script

cd "$(dirname "$0")"

# Check if venv exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate venv
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install -q -r requirements.txt

# Run the simulator
echo "Starting MeshCore Network Simulator..."
echo "Open http://localhost:4000 in your browser"
python app.py
