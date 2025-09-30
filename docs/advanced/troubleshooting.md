# Troubleshooting

Comprehensive guide to diagnosing and fixing common issues with NameMC Sniper.

## :mag: Quick Diagnosis

Run these commands to quickly identify issues:

```bash
# Check system status
python Main.py version
python Main.py config-validate
python Main.py test-proxies

# Test with dry run
python Main.py snipe --dry-run --debug
```

## :exclamation: Common Issues

### Authentication Problems

#### "Bearer token is required"

**Symptoms:**
- Error message about missing bearer token
- Authentication failures during sniping

**Causes:**
- Bearer token not set in config
- Token expired or invalid
- Incorrect token format

**Solutions:**

1. **Check token in config:**
   ```yaml
   snipe:
     bearer_token: "your_token_here"  # Must not be empty
   ```

2. **Validate token format:**
   ```bash
   # Token should start with "eyJ" and be very long
   echo $MINECRAFT_BEARER_TOKEN | wc -c  # Should be 800+ characters
   ```

3. **Test token validity:**
   ```bash
   curl -H "Authorization: Bearer YOUR_TOKEN" \
        https://api.minecraftservices.com/minecraft/profile
   ```

4. **Get new token:**
   - Follow [Authentication Guide](../getting-started/authentication.md)
   - Tokens typically expire after 24 hours

#### "Unauthorized access" / HTTP 401

**Symptoms:**
- HTTP 401 responses during sniping
- "Unauthorized" error messages

**Causes:**
- Expired bearer token
- Invalid token
- Account doesn't own Minecraft
- Token for wrong account

**Solutions:**

1. **Verify account ownership:**
   ```bash
   curl -H "Authorization: Bearer YOUR_TOKEN" \
        https://api.minecraftservices.com/minecraft/profile
   ```
   Should return your Minecraft profile, not an error.

2. **Check token expiration:**
   ```python
   import jwt
   import json
   
   # Decode token (without verification)
   token = "your_bearer_token"
   decoded = jwt.decode(token, options={"verify_signature": False})
   print(json.dumps(decoded, indent=2))
   ```

3. **Refresh token:**
   - Get a new bearer token from minecraft.net
   - Update config with new token

### Proxy Issues

#### "No working proxies available"

**Symptoms:**
- Error about proxy availability
- All proxy tests failing
- Connection timeouts

**Causes:**
- Proxy servers are down
- Incorrect proxy format
- Authentication issues
- Network connectivity problems

**Solutions:**

1. **Test individual proxies:**
   ```bash
   # Test with curl
   curl --proxy "http://proxy:port" "https://api.minecraft.net/status"
   
   # Test with authentication
   curl --proxy "http://user:pass@proxy:port" "https://api.minecraft.net/status"
   ```

2. **Check proxy format:**
   ```yaml
   proxy:
     proxies:
       - "http://ip:port"                    # Basic HTTP
       - "http://user:pass@ip:port"          # With auth
       - "https://ip:port"                   # HTTPS
       - "socks5://ip:port"                  # SOCKS5
   ```

3. **Validate proxy credentials:**
   - Check username/password are correct
   - Ensure special characters are URL-encoded
   - Verify proxy subscription is active

4. **Test network connectivity:**
   ```bash
   # Test direct connection
   curl "https://api.minecraft.net/status"
   
   # Test DNS resolution
   nslookup api.minecraft.net
   ```

#### "Proxy authentication failed" / HTTP 407

**Symptoms:**
- HTTP 407 responses
- Proxy authentication errors

**Causes:**
- Wrong username/password
- Special characters in credentials
- Proxy requires different auth method

**Solutions:**

1. **URL encode credentials:**
   ```python
   import urllib.parse
   
   username = urllib.parse.quote("user@domain.com")
   password = urllib.parse.quote("p@ssw0rd!")
   proxy = f"http://{username}:{password}@proxy:port"
   ```

2. **Test credentials manually:**
   ```bash
   curl --proxy-user "username:password" \
        --proxy "http://proxy:port" \
        "https://api.minecraft.net/status"
   ```

3. **Check proxy provider documentation:**
   - Some providers use different auth methods
   - Verify endpoint and port numbers
   - Check if IP whitelisting is required

### Discord Notification Issues

#### Discord notifications not working

**Symptoms:**
- No Discord messages received
- Webhook errors in logs
- Bot not responding

**Causes:**
- Invalid webhook URL
- Bot token issues
- Missing permissions
- Rate limiting

**Solutions:**

1. **Test webhook manually:**
   ```bash
   curl -X POST "YOUR_WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d '{"content": "Test message"}'
   ```

2. **Verify webhook URL:**
   ```yaml
   discord:
     webhook_url: "https://discord.com/api/webhooks/ID/TOKEN"
     # Should be complete URL, not just ID or token
   ```

3. **Check bot permissions:**
   - Send Messages
   - Embed Links
   - Read Message History
   - Use External Emojis (if using custom emojis)

4. **Test bot token:**
   ```python
   import discord
   
   client = discord.Client()
   
   @client.event
   async def on_ready():
       print(f'Bot logged in as {client.user}')
       await client.close()
   
   client.run('YOUR_BOT_TOKEN')
   ```

#### "Discord rate limited" / HTTP 429

**Symptoms:**
- HTTP 429 responses from Discord
- Delayed or missing notifications
- "Rate limited" in logs

**Causes:**
- Too many messages sent too quickly
- Multiple bots using same token
- Global Discord rate limits

**Solutions:**

1. **Reduce notification frequency:**
   ```yaml
   notifications:
     intervals:
       - 3600   # Remove shorter intervals
       - 1800
       - 300
       # Remove: 60, 30 second notifications
   ```

2. **Implement rate limiting:**
   ```yaml
   discord:
     rate_limit:
       max_messages_per_minute: 5
       burst_limit: 2
   ```

3. **Use webhooks instead of bots:**
   - Webhooks have higher rate limits
   - Easier to manage
   - More reliable for notifications

### Network and Performance Issues

#### "Connection timeout" / Network errors

**Symptoms:**
- Frequent connection timeouts
- Network-related errors
- Slow response times

**Causes:**
- Poor internet connection
- High network latency
- Firewall blocking connections
- DNS resolution issues

**Solutions:**

1. **Test network connectivity:**
   ```bash
   # Test latency to Minecraft servers
   ping api.minecraftservices.com
   ping sessionserver.mojang.com
   
   # Test DNS resolution
   nslookup api.minecraftservices.com
   ```

2. **Check firewall settings:**
   ```bash
   # Windows
   netsh advfirewall show allprofiles
   
   # Linux
   sudo ufw status
   iptables -L
   ```

3. **Optimize network settings:**
   ```yaml
   proxy:
     timeout: 15        # Increase timeout
     max_retries: 5     # More retries
   
   snipe:
     request_delay_ms: 50  # Slower requests
   ```

4. **Use different DNS servers:**
   ```bash
   # Use Google DNS
   echo "nameserver 8.8.8.8" > /etc/resolv.conf
   echo "nameserver 8.8.4.4" >> /etc/resolv.conf
   ```

#### High memory usage / Performance issues

**Symptoms:**
- High RAM usage
- Slow performance
- System freezing
- Out of memory errors

**Causes:**
- Too many concurrent requests
- Memory leaks
- Large log files
- Insufficient system resources

**Solutions:**

1. **Reduce resource usage:**
   ```yaml
   snipe:
     concurrent_requests: 5    # Reduce from higher values
     max_snipe_attempts: 50    # Limit attempts
   
   debug_mode: false           # Disable debug logging
   ```

2. **Monitor system resources:**
   ```bash
   # Linux
   htop
   free -h
   df -h
   
   # Windows
   taskmgr
   ```

3. **Clean up log files:**
   ```bash
   # Remove old logs
   find logs/ -name "*.log" -mtime +7 -delete
   
   # Limit log file size
   tail -n 1000 large_log.log > temp.log && mv temp.log large_log.log
   ```

4. **Optimize Python settings:**
   ```python
   import gc
   
   # Force garbage collection
   gc.collect()
   
   # Disable garbage collection during sniping
   gc.disable()
   ```

### Configuration Issues

#### "Configuration validation failed"

**Symptoms:**
- Config validation errors
- Invalid configuration messages
- Sniper won't start

**Causes:**
- Syntax errors in YAML
- Missing required fields
- Invalid values
- Incorrect data types

**Solutions:**

1. **Check YAML syntax:**
   ```bash
   # Validate YAML syntax
   python -c "import yaml; yaml.safe_load(open('config.yaml'))"
   ```

2. **Use config validation:**
   ```bash
   python Main.py config-validate --strict
   ```

3. **Recreate config:**
   ```bash
   # Backup current config
   cp config.yaml config.yaml.backup
   
   # Create new default config
   python Main.py config-create --overwrite
   ```

4. **Check required fields:**
   ```yaml
   snipe:
     target_username: "required"
     bearer_token: "required"
   
   proxy:
     enabled: true  # boolean, not string
     timeout: 10    # number, not string
   ```

## :wrench: Debugging Tools

### Enable Debug Mode

```bash
# Enable debug logging
python Main.py snipe --debug

# Or in config
debug_mode: true
log_level: "DEBUG"
```

### Log Analysis

```bash
# Search for errors in logs
grep -i "error" logs/namemc_sniper_*.log

# Find authentication issues
grep -i "auth\|401\|403" logs/namemc_sniper_*.log

# Check proxy issues
grep -i "proxy\|407\|timeout" logs/namemc_sniper_*.log

# Monitor real-time logs
tail -f logs/namemc_sniper_*.log
```

### Network Debugging

```python
# Add to your debugging script
import requests
import logging

# Enable requests debugging
logging.basicConfig(level=logging.DEBUG)
logging.getLogger("requests.packages.urllib3").setLevel(logging.DEBUG)
logging.getLogger("urllib3.connectionpool").setLevel(logging.DEBUG)

# Test request with full debugging
session = requests.Session()
response = session.get("https://api.minecraft.net/status")
print(f"Status: {response.status_code}")
print(f"Headers: {response.headers}")
```

### Performance Profiling

```python
import cProfile
import pstats

# Profile sniper performance
def profile_sniper():
    profiler = cProfile.Profile()
    profiler.enable()
    
    # Run sniper code here
    run_sniper()
    
    profiler.disable()
    
    # Analyze results
    stats = pstats.Stats(profiler)
    stats.sort_stats('cumulative')
    stats.print_stats(20)  # Top 20 functions

profile_sniper()
```

## :computer: System-Specific Issues

### Windows Issues

#### "Python not found" / Command not recognized

**Solutions:**
```cmd
# Add Python to PATH
set PATH=%PATH%;C:\Python39;C:\Python39\Scripts

# Or use py launcher
py Main.py snipe

# Install Python from Microsoft Store
winget install Python.Python.3.9
```

#### Windows Defender blocking

**Solutions:**
1. Add exclusion for NameMC Sniper folder
2. Temporarily disable real-time protection
3. Use Windows Security exclusions

#### PowerShell execution policy

**Solutions:**
```powershell
# Allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Or bypass for single command
powershell -ExecutionPolicy Bypass -File script.ps1
```

### Linux Issues

#### Permission denied errors

**Solutions:**
```bash
# Make script executable
chmod +x Main.py

# Install with user permissions
pip install --user -r requirements.txt

# Fix ownership
sudo chown -R $USER:$USER /path/to/namemc-sniper
```

#### Missing system dependencies

**Solutions:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3-dev python3-pip build-essential

# CentOS/RHEL
sudo yum install python3-devel python3-pip gcc

# Alpine
apk add python3-dev py3-pip gcc musl-dev
```

### macOS Issues

#### SSL certificate errors

**Solutions:**
```bash
# Update certificates
/Applications/Python\ 3.9/Install\ Certificates.command

# Or install certificates manually
pip install --upgrade certifi
```

#### Homebrew Python issues

**Solutions:**
```bash
# Use system Python
/usr/bin/python3 Main.py snipe

# Or reinstall Python
brew reinstall python@3.9
```

## :sos: Emergency Procedures

### Sniper Stuck/Frozen

1. **Graceful shutdown:**
   ```bash
   # Send interrupt signal
   Ctrl+C
   
   # Or kill by process name
   pkill -f "python.*Main.py"
   ```

2. **Force termination:**
   ```bash
   # Find process ID
   ps aux | grep "python.*Main.py"
   
   # Kill process
   kill -9 <PID>
   ```

3. **Clean up resources:**
   ```bash
   # Remove lock files
   rm -f *.lock
   
   # Clear temporary files
   rm -rf /tmp/namemc-sniper-*
   ```

### Recovery from Failed Snipe

1. **Analyze logs:**
   ```bash
   # Check what went wrong
   tail -n 100 logs/namemc_sniper_*.log
   ```

2. **Verify username status:**
   ```bash
   # Check if username was actually claimed
   curl "https://api.namemc.com/profile/USERNAME"
   ```

3. **Prepare for next attempt:**
   ```bash
   # Update configuration based on failure
   python Main.py config-validate --fix
   
   # Test setup
   python Main.py snipe --dry-run
   ```

## :telephone_receiver: Getting Help

### Before Asking for Help

1. **Check logs** for error messages
2. **Run diagnostics** commands
3. **Search documentation** for similar issues
4. **Try basic troubleshooting** steps

### Information to Include

When reporting issues, include:

- **Error messages** (full text)
- **Log files** (relevant portions)
- **Configuration** (sanitized, no tokens)
- **System information** (OS, Python version)
- **Steps to reproduce** the issue

### Diagnostic Information Script

```bash
#!/bin/bash
# Generate diagnostic information

echo "=== NameMC Sniper Diagnostics ==="
echo "Date: $(date)"
echo "System: $(uname -a)"
echo "Python: $(python --version)"
echo

echo "=== Configuration Status ==="
python Main.py config-validate
echo

echo "=== Proxy Status ==="
python Main.py test-proxies --timeout 5
echo

echo "=== Recent Logs ==="
tail -n 50 logs/namemc_sniper_*.log | grep -E "(ERROR|WARN|CRITICAL)"
echo

echo "=== Network Connectivity ==="
ping -c 3 api.minecraftservices.com
echo

echo "=== System Resources ==="
free -h 2>/dev/null || echo "Memory info not available"
df -h . 2>/dev/null || echo "Disk info not available"
```

## :arrow_right: Next Steps

- Review [Legal Notice](../legal/legal-notice.md) for compliance information
- Get additional support in [Support](../legal/support.md)
- Optimize performance with [Performance Optimization](performance.md)
