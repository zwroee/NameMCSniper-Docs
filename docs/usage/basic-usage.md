# Basic Usage

Learn the essential commands and workflows for using NameMC Sniper effectively.

## :rocket: Quick Start

**Recommended: Use the Interactive CLI Menu**

```bash
python menu.py
```

This launches the beautiful interactive menu where you can easily navigate through all options using numbered selections.

**Alternative: Direct Command Line**

```bash
python Main.py snipe -u "DesiredUsername" -t "your_bearer_token"
```

!!! tip "Why Use the Interactive Menu?"
    The CLI menu (`python menu.py`) provides a much better user experience with:
    
    - **Visual interface** with ASCII art and organized categories
    - **Easy navigation** with numbered options
    - **Real-time testing** and validation
    - **No need to remember complex commands**
    - **Built-in help and guidance**

## :gear: Command Structure

**Interactive Menu (Recommended):**
```bash
python menu.py
```

**Direct Commands (Advanced):**
```bash
python Main.py [COMMAND] [OPTIONS]
```

## :star: Essential Commands

### Start Sniping

**With config file:**
```bash
# Uses settings from config.yaml
python Main.py snipe
```

**With command line options:**
```bash
# Override config with CLI arguments
python Main.py snipe -u "Username" -t "bearer_token"
```

**With custom config:**
```bash
# Use a different config file
python Main.py snipe -c "custom_config.yaml"
```

### Configuration Management

**Create default configuration:**
```bash
python Main.py config-create
```

**Validate configuration:**
```bash
python Main.py config-validate
```

**Test proxy connections:**
```bash
python Main.py test-proxies
```

### Information Commands

**Show help:**
```bash
python Main.py --help
```

**Show version:**
```bash
python Main.py version
```

## :art: Interactive CLI Menu (`python menu.py`)

**Launch the interactive menu:**
```bash
python menu.py
```

**Features:**
- 🎨 **Beautiful ASCII Art** - Matrix-style green interface
- 📋 **Organized Categories** - Easy navigation with numbered options
- ⚡ **Real-time Testing** - Test tokens, proxies, and Discord integration
- 🔧 **Configuration Management** - Create, validate, and manage configs
- 📊 **System Information** - View logs, system stats, and performance data
- 🎯 **One-Click Sniping** - Simple username sniping at specific times

**Menu Categories:**
- **[1] Sniper Operations** - Main sniping functionality
- **[11-14] Configuration** - Config creation, validation, and management  
- **[21-24] Tools & Info** - Token testing, proxy testing, logs, system info
- **[31-33] Discord & Notifications** - Webhook setup and testing
- **[41-43] Advanced Options** - Performance tuning, debug mode
- **[51-53] Help & Support** - Documentation, about, GitHub links

### CLI Interface Preview

The interactive menu features a professional Matrix-style interface with:
- **Green ASCII Art Logo** - Eye-catching NameMC Sniper branding
- **Organized Menu Layout** - Clean categorized options in bordered boxes
- **Real-time Information** - Current time display and status updates
- **User-friendly Navigation** - Simple number-based option selection
- **Professional Styling** - Consistent green theme throughout

<img width="1918" height="983" alt="Screenshot 2025-09-30 063615" src="https://github.com/user-attachments/assets/387111dd-6039-46c1-b04c-73687cbb761a" />

## :workflow: Typical Workflow

### 1. Launch Interactive Menu

```bash
# Start the interactive CLI menu
python menu.py
```

### 2. Initial Setup (via Menu)

1. **Launch menu**: `python menu.py`
2. **Create configuration**: Select option `[11] Create Config`
3. **Edit config.yaml** with your settings (See Configuration guide)
4. **Validate configuration**: Select option `[12] Validate Config`

**Alternative (Command Line):**
```bash
# Create configuration
python Main.py config-create

# Validate configuration
python Main.py config-validate
```

### 3. Test Your Setup (via Menu)

**Using Interactive Menu (Recommended):**
1. Select option `[22] Test Proxies` (if using proxies)
2. Select option `[21] Test Token` to verify bearer token
3. Select option `[23] View Logs` to check for any issues

**Alternative (Command Line):**
```bash
# Test proxy connections (if using proxies)
python Main.py test-proxies

# Verify bearer token works
python Main.py snipe --dry-run
```

### 4. Start Sniping

**Using Interactive Menu (Recommended):**
1. Select option `[1] Start Sniper`
2. Follow the prompts to enter username and settings

**Alternative (Command Line):**
```bash
# Start the sniper
python Main.py snipe -u "TargetUsername"
```

## :bell: What Happens When You Run

When you start sniping, NameMC Sniper will:

1. **Load Configuration** - Read settings from config file
2. **Validate Setup** - Check bearer token, proxies, Discord webhook
3. **Schedule Notifications** - Set up countdown alerts
4. **Monitor Drop Time** - Wait for the username to become available
5. **Start Sniping** - Begin high-speed claiming attempts
6. **Report Results** - Send success/failure notifications

## :chart_with_upwards_trend: Monitoring Progress

### Console Output

The sniper provides real-time feedback:

```
[INFO] Starting NameMC Sniper v1.0.0
[INFO] Target username: ExampleUser
[INFO] Drop time: 2024-01-15 14:30:00 UTC
[INFO] Notifications scheduled: 8 intervals
[INFO] Proxies loaded: 5 working proxies
[INFO] Discord webhook: Connected
[INFO] Waiting for drop time...
[NOTIFICATION] 24 hours until drop
[NOTIFICATION] 12 hours until drop
...
[SNIPE] Starting snipe attempts (30s before drop)
[SUCCESS] Username claimed successfully!
```

### Log Files

Detailed logs are saved to:
```
logs/namemc_sniper_YYYYMMDD_HHMMSS.log
```

## :wrench: Command Options

### Global Options

| Option | Description | Example |
|--------|-------------|---------|
| `--help` | Show help message | `python Main.py --help` |
| `--version` | Show version info | `python Main.py --version` |
| `--config` | Custom config file | `python Main.py --config custom.yaml` |

### Snipe Command Options

| Option | Short | Description | Example |
|--------|-------|-------------|---------|
| `--username` | `-u` | Target username | `-u "DesiredName"` |
| `--token` | `-t` | Bearer token | `-t "eyJ0eXAi..."` |
| `--config` | `-c` | Config file path | `-c "config.yaml"` |
| `--dry-run` | | Test without sniping | `--dry-run` |
| `--debug` | | Enable debug mode | `--debug` |

## :bulb: Pro Tips

### Timing Your Snipe

- **Start early**: Begin monitoring 24+ hours before drop
- **Test first**: Use `--dry-run` to verify setup
- **Check timezone**: Ensure drop time is in correct timezone

### Optimizing Performance

- **Use proxies**: Rotate through multiple high-quality proxies
- **Tune settings**: Adjust `request_delay_ms` and `concurrent_requests`
- **Monitor logs**: Watch for rate limiting or errors

### Discord Integration

- **Test webhook**: Send a test message before the drop
- **Set role mentions**: Get notified immediately on mobile
- **Use embeds**: Rich formatting for better visibility

## :warning: Common Mistakes

**❌ Starting too late**
```bash
# Don't wait until the last minute
python Main.py snipe  # Started 5 minutes before drop
```

**✅ Start monitoring early**
```bash
# Start 24+ hours early for notifications
python Main.py snipe  # Started 1 day before drop
```

**❌ Not testing setup**
```bash
# Don't skip validation
python Main.py snipe  # Untested configuration
```

**✅ Always validate first**
```bash
# Test everything before the drop
python Main.py config-validate
python Main.py test-proxies
python Main.py snipe --dry-run
```

## :exclamation: Troubleshooting Quick Fixes

**Command not found:**
```bash
# Make sure you're in the right directory
cd /path/to/NameMcSniper
python Main.py --help
```

**Config file not found:**
```bash
# Create default config first
python Main.py config-create
```

**Bearer token errors:**
```bash
# Verify token is valid
python Main.py snipe --dry-run
```

## :arrow_right: Next Steps

- Learn all available commands in [Command Reference](commands.md)
- Set up Discord notifications in [Discord Setup](discord-setup.md)
- Configure proxies in [Proxy Setup](proxy-setup.md)
