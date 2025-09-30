#!/bin/bash

echo "Setting up NameMC Sniper Documentation..."
echo

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    if ! command -v python &> /dev/null; then
        echo "ERROR: Python is not installed"
        echo "Please install Python 3.8+ from your package manager"
        exit 1
    fi
    PYTHON_CMD="python"
else
    PYTHON_CMD="python3"
fi

echo "Python found. Installing dependencies..."

# Install dependencies
$PYTHON_CMD -m pip install -r requirements.txt

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install dependencies"
    exit 1
fi

echo
echo "Dependencies installed successfully!"
echo
echo "To start the documentation server, run:"
echo "  mkdocs serve"
echo
echo "Then open your browser to: http://127.0.0.1:8000"
echo

# Make the script executable
chmod +x setup.sh
