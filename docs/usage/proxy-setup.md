# Proxy Setup

Configure proxy rotation to improve sniping performance and avoid rate limiting.

## :globe_with_meridians: Why Use Proxies?

Proxies provide several benefits for username sniping:

- **Avoid rate limiting** - Distribute requests across multiple IP addresses
- **Improve success rate** - Multiple connection paths to Minecraft servers
- **Geographic advantage** - Use proxies closer to Minecraft servers
- **Redundancy** - Continue sniping if one proxy fails

## :gear: Proxy Configuration

### Basic Setup

Add proxies to your `config.yaml`:

```yaml
proxy:
  enabled: true
  proxies:
    - "http://proxy1.example.com:8080"
    - "http://proxy2.example.com:8080"
    - "http://proxy3.example.com:8080"
  rotation_enabled: true
  timeout: 10
  max_retries: 3
```

### Advanced Configuration

```yaml
proxy:
  enabled: true
  proxies:
    - "http://user:pass@proxy1.example.com:8080"
    - "https://proxy2.example.com:3128"
    - "socks5://proxy3.example.com:1080"
  rotation_enabled: true
  timeout: 10
  max_retries: 3
  health_check:
    enabled: true
    interval: 300  # Check every 5 minutes
    url: "https://api.minecraft.net/status"
  load_balancing:
    method: "round_robin"  # round_robin, random, least_used
    sticky_sessions: false
```

## :link: Supported Proxy Types

### HTTP Proxies

Most common and widely supported:

```yaml
proxies:
  - "http://ip:port"
  - "http://username:password@ip:port"
```

### HTTPS Proxies

Encrypted HTTP proxies:

```yaml
proxies:
  - "https://ip:port"
  - "https://username:password@ip:port"
```

### SOCKS5 Proxies

More versatile, supports UDP:

```yaml
proxies:
  - "socks5://ip:port"
  - "socks5://username:password@ip:port"
```

## :shopping_cart: Proxy Providers

### Recommended Providers

**Residential Proxies** (Best for sniping):
- **Bright Data** - High quality, expensive
- **Oxylabs** - Good performance, reliable
- **Smartproxy** - Affordable residential proxies

**Datacenter Proxies** (Budget option):
- **ProxyRack** - Cheap datacenter proxies
- **MyPrivateProxy** - Dedicated proxies
- **HighProxies** - Shared and dedicated options

### Proxy Requirements

For optimal sniping performance:

- **Low latency** (<100ms to Minecraft servers)
- **High uptime** (>99%)
- **Good speed** (>10 Mbps)
- **Geographic diversity** (multiple locations)
- **Rotating IPs** (to avoid detection)

## :test_tube: Testing Proxies

### Built-in Proxy Testing

Test all configured proxies:

```bash
python Main.py test-proxies
```

Test with custom timeout:

```bash
python Main.py test-proxies --timeout 5
```

Verbose output with detailed results:

```bash
python Main.py test-proxies --verbose --export "proxy-results.json"
```

### Manual Proxy Testing

Test individual proxies with curl:

```bash
# Test HTTP proxy
curl --proxy "http://proxy:port" "https://api.minecraft.net/status"

# Test with authentication
curl --proxy "http://user:pass@proxy:port" "https://api.minecraft.net/status"

# Test SOCKS5 proxy
curl --socks5 "proxy:port" "https://api.minecraft.net/status"
```

### Python Testing Script

```python
import requests
import time

def test_proxy(proxy_url):
    try:
        proxies = {"http": proxy_url, "https": proxy_url}
        start_time = time.time()
        
        response = requests.get(
            "https://api.minecraft.net/status",
            proxies=proxies,
            timeout=10
        )
        
        latency = (time.time() - start_time) * 1000
        
        if response.status_code == 200:
            print(f"✅ {proxy_url} - {latency:.0f}ms")
            return True
        else:
            print(f"❌ {proxy_url} - Status: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ {proxy_url} - Error: {str(e)}")
        return False

# Test your proxies
proxies = [
    "http://proxy1:port",
    "http://proxy2:port",
    "http://proxy3:port"
]

for proxy in proxies:
    test_proxy(proxy)
```

## :arrows_clockwise: Rotation Strategies

### Round Robin

Cycle through proxies in order:

```yaml
proxy:
  load_balancing:
    method: "round_robin"
```

### Random Selection

Randomly select proxies:

```yaml
proxy:
  load_balancing:
    method: "random"
```

### Least Used

Use the proxy with fewest recent requests:

```yaml
proxy:
  load_balancing:
    method: "least_used"
```

### Performance-Based

Prioritize faster proxies:

```yaml
proxy:
  load_balancing:
    method: "performance"
    metrics:
      - "latency"
      - "success_rate"
      - "uptime"
```

## :wrench: Optimization Settings

### Connection Settings

```yaml
proxy:
  timeout: 10              # Connection timeout (seconds)
  max_retries: 3           # Retry attempts per proxy
  retry_delay: 1           # Delay between retries (seconds)
  connection_pool_size: 10 # Max concurrent connections per proxy
```

### Health Monitoring

```yaml
proxy:
  health_check:
    enabled: true
    interval: 300           # Check every 5 minutes
    timeout: 5              # Health check timeout
    failure_threshold: 3    # Failures before marking unhealthy
    recovery_threshold: 2   # Successes before marking healthy
    endpoints:
      - "https://api.minecraft.net/status"
      - "https://sessionserver.mojang.com/session/minecraft/profile/test"
```

### Automatic Failover

```yaml
proxy:
  failover:
    enabled: true
    max_failures: 5         # Max failures before switching
    cooldown_period: 300    # Seconds before retrying failed proxy
    fallback_to_direct: true # Use direct connection if all proxies fail
```

## :chart_with_upwards_trend: Performance Monitoring

### Proxy Metrics

Monitor proxy performance:

```yaml
proxy:
  monitoring:
    enabled: true
    metrics:
      - "latency"
      - "success_rate"
      - "bandwidth"
      - "uptime"
    export_interval: 3600   # Export metrics every hour
    export_format: "json"   # json, csv, prometheus
```

### Logging

Enable detailed proxy logging:

```yaml
logging:
  level: "DEBUG"
  proxy_logs: true
  include_metrics: true
```

## :warning: Common Issues

### Proxy Authentication Errors

**Problem**: 407 Proxy Authentication Required

**Solutions**:
- Verify username/password are correct
- Check if proxy requires different auth method
- Ensure special characters are URL-encoded

```python
import urllib.parse

username = urllib.parse.quote("user@domain.com")
password = urllib.parse.quote("p@ssw0rd!")
proxy = f"http://{username}:{password}@proxy:port"
```

### Connection Timeouts

**Problem**: Proxies timing out frequently

**Solutions**:
- Increase timeout values
- Use proxies closer to Minecraft servers
- Test proxy speed and stability
- Reduce concurrent connections per proxy

### Rate Limiting

**Problem**: Getting rate limited despite using proxies

**Solutions**:
- Use more proxies
- Increase delays between requests
- Use residential proxies instead of datacenter
- Implement better rotation logic

### IP Blocking

**Problem**: Proxy IPs getting blocked

**Solutions**:
- Use high-quality residential proxies
- Rotate IPs more frequently
- Avoid aggressive request patterns
- Use proxies from different subnets

## :shield: Security Considerations

### Proxy Security

- **Use HTTPS proxies** when possible
- **Verify proxy provider reputation**
- **Monitor for data leaks**
- **Avoid free public proxies**

### Authentication Security

- **Store credentials securely**
- **Use environment variables**
- **Rotate credentials regularly**
- **Monitor for unauthorized access**

```yaml
# Secure credential storage
proxy:
  proxies:
    - "http://${PROXY_USER}:${PROXY_PASS}@proxy1:port"
    - "http://${PROXY_USER}:${PROXY_PASS}@proxy2:port"
```

## :bulb: Best Practices

### Proxy Selection

1. **Quality over quantity** - Better to have 5 good proxies than 50 bad ones
2. **Geographic diversity** - Use proxies from different regions
3. **Provider diversity** - Don't rely on a single provider
4. **Regular testing** - Monitor proxy health continuously

### Configuration Tips

1. **Start conservative** - Begin with higher timeouts and delays
2. **Monitor performance** - Track success rates and adjust
3. **Plan for failures** - Always have backup proxies
4. **Test before sniping** - Validate setup before important drops

### Cost Optimization

1. **Residential for important snipes** - Use premium proxies for valuable usernames
2. **Datacenter for testing** - Use cheaper proxies for development
3. **Monitor usage** - Track bandwidth and request limits
4. **Optimize rotation** - Reduce unnecessary proxy switches

## :arrow_right: Next Steps

- Learn about performance optimization in [Performance Optimization](../advanced/performance.md)
- Understand the sniping process in [How It Works](../advanced/how-it-works.md)
- Troubleshoot issues in [Troubleshooting](../advanced/troubleshooting.md)
