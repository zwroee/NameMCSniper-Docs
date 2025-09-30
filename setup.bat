@echo off
echo Setting up NameMC Sniper Documentation...
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.8+ from https://python.org
    pause
    exit /b 1
)

echo Python found. Installing dependencies...
pip install -r requirements.txt

if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Dependencies installed successfully!
echo.
echo To start the documentation server, run:
echo   mkdocs serve
echo.
echo Then open your browser to: http://127.0.0.1:8000
echo.
pause
