# Installation

This guide will help you install NameMC Sniper and its dependencies on your system.

## :computer: System Requirements

- **Python**: 3.8 or higher
- **Operating System**: Windows, macOS, or Linux
- **Network**: Stable internet connection
- **Memory**: At least 512MB RAM available

## :package: Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/zwroee/NameMCSniper.git
cd NameMCSniper
```

### 2. Install Python Dependencies

```bash
pip install -r requirements.txt
```

!!! info "Virtual Environment (Recommended)"
    It's recommended to use a virtual environment to avoid conflicts with other Python packages:
    
    ```bash
    # Create virtual environment
    python -m venv namemc-sniper-env
    
    # Activate virtual environment
    # On Windows:
    namemc-sniper-env\Scripts\activate
    # On macOS/Linux:
    source namemc-sniper-env/bin/activate
    
    # Install dependencies
    pip install -r requirements.txt
    ```

### 3. Verify Installation

Test that the installation was successful:

```bash
python Main.py --help
```

You should see the help menu with available commands.

### 4. Create Initial Configuration

Generate the default configuration file:

```bash
python Main.py config-create
```

This will create a `config.yaml` file in your project directory.

## :gear: Dependencies

The main dependencies include:

- **requests** - HTTP library for API calls
- **pyyaml** - YAML configuration file support
- **rich** - Beautiful terminal output
- **discord.py** - Discord bot integration (optional)
- **schedule** - Task scheduling
- **colorama** - Cross-platform colored terminal text

## :white_check_mark: Verification

To ensure everything is working correctly:

1. **Check version**:
   ```bash
   python Main.py version
   ```

2. **Validate configuration**:
   ```bash
   python Main.py config-validate
   ```

3. **Test proxy connections** (if using proxies):
   ```bash
   python Main.py test-proxies
   ```

## :exclamation: Troubleshooting Installation

### Common Issues

**Python not found**
```bash
# Make sure Python is in your PATH
python --version
# or try
python3 --version
```

**Permission errors**
```bash
# On Windows, run as administrator
# On macOS/Linux, use sudo if needed
sudo pip install -r requirements.txt
```

**Module not found errors**
```bash
# Ensure you're in the correct directory
ls -la  # Should show Main.py and requirements.txt
# Reinstall dependencies
pip install -r requirements.txt --force-reinstall
```

## :arrow_right: Next Steps

Once installation is complete, proceed to [Configuration](configuration.md) to set up your sniper settings.
