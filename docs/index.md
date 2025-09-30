# NameMC Sniper

A powerful CLI Minecraft username sniper that uses the NameMC API with proxy support and Discord notifications. Features automated monitoring, scheduled notifications, and high-speed sniping with bearer token authentication.

![NameMC Sniper](https://img.shields.io/badge/NameMC-Sniper-green?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3.8+-blue?style=for-the-badge&logo=python)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

## :rocket: Features

- :lock: **Bearer Token Authentication** - Secure authentication without email/password
- :globe_with_meridians: **Proxy Support** - Rotate through multiple proxies with health checking
- :loudspeaker: **Discord Notifications** - Real-time updates via webhook or bot
- :alarm_clock: **Scheduled Notifications** - Alerts at 24h, 12h, 6h, 2h, 1h, 30m, 5m, 1m, 30s before drop
- :zap: **High-Speed Sniping** - Concurrent requests with minimal delay
- :art: **Rich CLI Interface** - Beautiful terminal output with colors and tables
- :bar_chart: **Comprehensive Logging** - Detailed logs with configurable levels

## :fast_forward: Quick Start

1. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Create Configuration**
   ```bash
   python Main.py config-create
   ```

3. **Start Sniping**
   ```bash
   python Main.py snipe -u "DesiredUsername" -t "your_bearer_token"
   ```

## :books: Documentation Sections

### Getting Started
- [Installation](getting-started/installation.md) - Set up NameMC Sniper on your system
- [Configuration](getting-started/configuration.md) - Configure the sniper for optimal performance
- [Authentication](getting-started/authentication.md) - Get your Minecraft bearer token

### Usage
- [Basic Usage](usage/basic-usage.md) - Learn the essential commands
- [Command Reference](usage/commands.md) - Complete command documentation
- [Discord Setup](usage/discord-setup.md) - Configure Discord notifications
- [Proxy Setup](usage/proxy-setup.md) - Set up proxy rotation

### Advanced
- [How It Works](advanced/how-it-works.md) - Understanding the sniping process
- [Performance Optimization](advanced/performance.md) - Maximize sniping success
- [Troubleshooting](advanced/troubleshooting.md) - Solve common issues

## :warning: Important Notice

!!! warning "Educational Purpose Only"
    This tool is for educational purposes only. Make sure to comply with Minecraft's Terms of Service and use responsibly.

## :handshake: Support

Need help? Check out our [Support](legal/support.md) page for assistance options.

---

**Ready to get started?** Head over to the [Installation](getting-started/installation.md) guide!
