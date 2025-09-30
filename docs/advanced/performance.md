# Performance Optimization

Maximize your sniping success rate with advanced performance tuning techniques.

## :zap: Quick Performance Checklist

- [ ] Use high-quality residential proxies
- [ ] Optimize `concurrent_requests` and `request_delay_ms`
- [ ] Run on a server with low latency to Minecraft servers
- [ ] Use SSD storage for faster I/O
- [ ] Ensure stable, high-speed internet connection
- [ ] Monitor system resources during sniping

## :gear: Configuration Optimization

### High-Performance Configuration

For maximum speed and success rate:

```yaml
snipe:
  start_sniping_at_seconds: 30
  max_snipe_attempts: 200
  request_delay_ms: 10        # Aggressive timing
  concurrent_requests: 20     # High concurrency
  use_multiple_threads: true

proxy:
  enabled: true
  rotation_enabled: true
  timeout: 5                  # Fast timeout
  max_retries: 2              # Quick failover

discord:
  enabled: false              # Disable during snipe for performance
```

### Conservative Configuration

For stability and compliance:

```yaml
snipe:
  start_sniping_at_seconds: 45
  max_snipe_attempts: 100
  request_delay_ms: 50        # Respectful timing
  concurrent_requests: 5      # Lower concurrency
  use_multiple_threads: true

proxy:
  enabled: true
  rotation_enabled: true
  timeout: 10                 # Longer timeout
  max_retries: 3              # More retries

discord:
  enabled: true               # Keep notifications
```

## :chart_with_upwards_trend: Performance Tuning Guide

### 1. Concurrent Requests Optimization

Find the optimal number of concurrent requests:

```python
# Test different concurrency levels
concurrency_levels = [1, 5, 10, 15, 20, 25, 30]
results = {}

for level in concurrency_levels:
    config.concurrent_requests = level
    success_rate = run_performance_test(config)
    results[level] = success_rate
    
# Find optimal level
optimal_level = max(results, key=results.get)
print(f"Optimal concurrency: {optimal_level}")
```

**Guidelines:**
- **Start with 10** concurrent requests
- **Increase gradually** while monitoring success rate
- **Watch for diminishing returns** - more isn't always better
- **Consider proxy limits** - don't exceed proxy capacity

### 2. Request Delay Optimization

Balance speed with rate limiting:

```yaml
# Ultra-aggressive (high risk)
request_delay_ms: 5

# Aggressive (medium risk)
request_delay_ms: 15

# Balanced (recommended)
request_delay_ms: 25

# Conservative (low risk)
request_delay_ms: 50
```

**Testing methodology:**
```bash
# Test different delays
for delay in 5 10 15 25 50; do
    echo "Testing delay: ${delay}ms"
    python Main.py snipe --dry-run --request-delay $delay
done
```

### 3. Proxy Performance Optimization

#### Proxy Selection Criteria

**Latency Testing:**
```python
import time
import requests

def test_proxy_latency(proxy_url):
    latencies = []
    
    for _ in range(10):
        start = time.time()
        try:
            response = requests.get(
                "https://api.minecraft.net/status",
                proxies={"http": proxy_url, "https": proxy_url},
                timeout=5
            )
            if response.status_code == 200:
                latency = (time.time() - start) * 1000
                latencies.append(latency)
        except:
            continue
    
    if latencies:
        avg_latency = sum(latencies) / len(latencies)
        return avg_latency
    return float('inf')

# Test all proxies and rank by latency
proxy_performance = {}
for proxy in proxy_list:
    latency = test_proxy_latency(proxy)
    proxy_performance[proxy] = latency

# Sort by performance
sorted_proxies = sorted(proxy_performance.items(), key=lambda x: x[1])
```

#### Geographic Optimization

**Recommended proxy locations:**
1. **US East Coast** - Closest to many Minecraft servers
2. **US West Coast** - Good for Pacific region
3. **Europe (London/Amsterdam)** - European servers
4. **Singapore** - Asian servers

```yaml
proxy:
  proxies:
    # Prioritize by geographic proximity to Minecraft servers
    - "http://us-east-proxy1:port"     # Primary
    - "http://us-east-proxy2:port"     # Backup
    - "http://us-west-proxy1:port"     # Secondary
    - "http://europe-proxy1:port"      # Tertiary
```

## :computer: System Optimization

### Hardware Requirements

**Minimum specs:**
- **CPU**: 2 cores, 2.0 GHz
- **RAM**: 4 GB
- **Storage**: 1 GB free space
- **Network**: 10 Mbps stable connection

**Recommended specs:**
- **CPU**: 4+ cores, 3.0+ GHz
- **RAM**: 8+ GB
- **Storage**: SSD with 10+ GB free
- **Network**: 100+ Mbps with low latency

**Optimal specs:**
- **CPU**: 8+ cores, 3.5+ GHz (Intel i7/AMD Ryzen 7+)
- **RAM**: 16+ GB
- **Storage**: NVMe SSD
- **Network**: Gigabit fiber with <10ms latency

### Operating System Tuning

#### Linux Optimization

```bash
# Increase file descriptor limits
echo "* soft nofile 65536" >> /etc/security/limits.conf
echo "* hard nofile 65536" >> /etc/security/limits.conf

# Optimize network stack
echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 4096 65536 16777216" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 4096 65536 16777216" >> /etc/sysctl.conf

# Apply changes
sysctl -p
```

#### Windows Optimization

```powershell
# Increase network buffer sizes
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global rss=enabled

# Disable unnecessary services
sc config "Windows Search" start= disabled
sc config "Superfetch" start= disabled
```

### Python Optimization

```python
# Optimize Python runtime
import sys
import gc

# Disable garbage collection during sniping
gc.disable()

# Increase recursion limit if needed
sys.setrecursionlimit(10000)

# Use faster JSON library
try:
    import ujson as json
except ImportError:
    import json

# Optimize imports
from requests import Session
from concurrent.futures import ThreadPoolExecutor
from asyncio import create_task, gather
```

## :cloud: Cloud Deployment

### VPS Recommendations

**Budget option:**
- **DigitalOcean**: $5/month droplet
- **Vultr**: $2.50/month instance
- **Linode**: $5/month nanode

**Performance option:**
- **AWS EC2**: t3.medium or c5.large
- **Google Cloud**: n1-standard-2
- **Azure**: Standard_B2s

**Premium option:**
- **Dedicated servers** with guaranteed resources
- **Bare metal** for maximum performance
- **Edge locations** close to Minecraft servers

### Docker Deployment

```dockerfile
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Optimize Python
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Run sniper
CMD ["python", "Main.py", "snipe"]
```

```yaml
# docker-compose.yml
version: '3.8'
services:
  namemc-sniper:
    build: .
    volumes:
      - ./config.yaml:/app/config.yaml
      - ./logs:/app/logs
    environment:
      - MINECRAFT_BEARER_TOKEN=${BEARER_TOKEN}
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 2G
```

## :stopwatch: Timing Optimization

### Network Latency Measurement

```python
import ping3

def measure_latency_to_minecraft():
    minecraft_servers = [
        "api.minecraftservices.com",
        "sessionserver.mojang.com",
        "api.mojang.com"
    ]
    
    latencies = {}
    for server in minecraft_servers:
        try:
            latency = ping3.ping(server, timeout=5)
            if latency:
                latencies[server] = latency * 1000  # Convert to ms
        except:
            latencies[server] = float('inf')
    
    return latencies

# Optimize start timing based on latency
latencies = measure_latency_to_minecraft()
avg_latency = sum(l for l in latencies.values() if l != float('inf')) / len(latencies)

# Adjust start time based on latency
if avg_latency < 50:
    start_seconds = 25  # Low latency - start closer to drop
elif avg_latency < 100:
    start_seconds = 30  # Medium latency - default timing
else:
    start_seconds = 40  # High latency - start earlier
```

### Clock Synchronization

```python
import ntplib
from datetime import datetime, timedelta

def sync_system_clock():
    try:
        ntp_client = ntplib.NTPClient()
        response = ntp_client.request('pool.ntp.org')
        
        # Calculate time offset
        system_time = datetime.now().timestamp()
        ntp_time = response.tx_time
        offset = ntp_time - system_time
        
        print(f"System clock offset: {offset:.3f} seconds")
        
        # Warn if offset is significant
        if abs(offset) > 1.0:
            print("WARNING: System clock is significantly off!")
            print("Consider syncing your system clock for optimal performance")
        
        return offset
    except Exception as e:
        print(f"Could not sync clock: {e}")
        return 0

# Use offset in timing calculations
clock_offset = sync_system_clock()
adjusted_drop_time = drop_time + timedelta(seconds=clock_offset)
```

## :bar_chart: Performance Monitoring

### Real-time Metrics Dashboard

```python
import time
from collections import deque

class PerformanceMonitor:
    def __init__(self):
        self.start_time = time.time()
        self.request_times = deque(maxlen=100)
        self.success_count = 0
        self.error_count = 0
        self.proxy_switches = 0
    
    def record_request(self, response_time, success=True):
        self.request_times.append(response_time)
        if success:
            self.success_count += 1
        else:
            self.error_count += 1
    
    def get_stats(self):
        if not self.request_times:
            return {}
        
        return {
            'avg_response_time': sum(self.request_times) / len(self.request_times),
            'min_response_time': min(self.request_times),
            'max_response_time': max(self.request_times),
            'success_rate': self.success_count / (self.success_count + self.error_count) * 100,
            'requests_per_second': len(self.request_times) / (time.time() - self.start_time),
            'total_requests': self.success_count + self.error_count
        }
    
    def print_dashboard(self):
        stats = self.get_stats()
        print("\n" + "="*50)
        print("PERFORMANCE DASHBOARD")
        print("="*50)
        print(f"Avg Response Time: {stats.get('avg_response_time', 0):.0f}ms")
        print(f"Success Rate: {stats.get('success_rate', 0):.1f}%")
        print(f"Requests/Second: {stats.get('requests_per_second', 0):.1f}")
        print(f"Total Requests: {stats.get('total_requests', 0)}")
        print("="*50)
```

### Automated Performance Testing

```python
def run_performance_benchmark(config_variations):
    results = {}
    
    for name, config in config_variations.items():
        print(f"Testing configuration: {name}")
        
        # Run test with this configuration
        start_time = time.time()
        success_rate = simulate_snipe_attempts(config)
        duration = time.time() - start_time
        
        results[name] = {
            'success_rate': success_rate,
            'duration': duration,
            'score': success_rate / duration  # Success per second
        }
    
    # Find best configuration
    best_config = max(results, key=lambda x: results[x]['score'])
    print(f"Best configuration: {best_config}")
    
    return results

# Test different configurations
configs = {
    'conservative': {'concurrent_requests': 5, 'request_delay_ms': 50},
    'balanced': {'concurrent_requests': 10, 'request_delay_ms': 25},
    'aggressive': {'concurrent_requests': 20, 'request_delay_ms': 10},
    'extreme': {'concurrent_requests': 50, 'request_delay_ms': 5}
}

benchmark_results = run_performance_benchmark(configs)
```

## :warning: Performance vs. Risk Balance

### Risk Assessment Matrix

| Configuration | Success Rate | Risk Level | Recommended Use |
|---------------|--------------|------------|-----------------|
| Conservative | 60-70% | Low | Testing, low-value usernames |
| Balanced | 70-80% | Medium | Most usernames |
| Aggressive | 80-90% | High | High-value usernames |
| Extreme | 85-95% | Very High | Critical usernames only |

### Rate Limiting Indicators

Watch for these signs of rate limiting:
- **HTTP 429** responses
- **Sudden drop** in success rate
- **Increasing response times**
- **Connection timeouts**

```python
def detect_rate_limiting(response_times, success_rates):
    # Check for sudden performance degradation
    recent_times = response_times[-10:]
    recent_success = success_rates[-10:]
    
    if len(recent_times) >= 5:
        avg_recent = sum(recent_times) / len(recent_times)
        avg_overall = sum(response_times) / len(response_times)
        
        # Response time increased significantly
        if avg_recent > avg_overall * 2:
            return "High response times detected - possible rate limiting"
    
    if len(recent_success) >= 5:
        recent_avg = sum(recent_success) / len(recent_success)
        
        # Success rate dropped significantly
        if recent_avg < 0.5:
            return "Low success rate detected - possible rate limiting"
    
    return None
```

## :bulb: Advanced Techniques

### Adaptive Configuration

```python
class AdaptiveSniper:
    def __init__(self, base_config):
        self.config = base_config
        self.performance_history = []
    
    def adapt_configuration(self, current_performance):
        self.performance_history.append(current_performance)
        
        # If performance is declining, become more conservative
        if len(self.performance_history) >= 3:
            recent_avg = sum(self.performance_history[-3:]) / 3
            overall_avg = sum(self.performance_history) / len(self.performance_history)
            
            if recent_avg < overall_avg * 0.8:
                # Performance declining - reduce aggressiveness
                self.config.request_delay_ms = min(self.config.request_delay_ms * 1.2, 100)
                self.config.concurrent_requests = max(self.config.concurrent_requests - 2, 1)
            elif recent_avg > overall_avg * 1.2:
                # Performance improving - increase aggressiveness
                self.config.request_delay_ms = max(self.config.request_delay_ms * 0.9, 5)
                self.config.concurrent_requests = min(self.config.concurrent_requests + 1, 50)
```

### Machine Learning Optimization

```python
from sklearn.ensemble import RandomForestRegressor
import numpy as np

class MLPerformanceOptimizer:
    def __init__(self):
        self.model = RandomForestRegressor()
        self.training_data = []
    
    def collect_training_data(self, config, performance):
        features = [
            config.concurrent_requests,
            config.request_delay_ms,
            len(config.proxies),
            config.start_sniping_at_seconds
        ]
        self.training_data.append((features, performance))
    
    def train_model(self):
        if len(self.training_data) < 10:
            return False
        
        X = np.array([data[0] for data in self.training_data])
        y = np.array([data[1] for data in self.training_data])
        
        self.model.fit(X, y)
        return True
    
    def optimize_config(self, base_config):
        if not self.train_model():
            return base_config
        
        # Test different configurations
        best_config = base_config
        best_score = 0
        
        for concurrent in range(5, 51, 5):
            for delay in range(5, 101, 10):
                test_features = [concurrent, delay, len(base_config.proxies), 30]
                predicted_performance = self.model.predict([test_features])[0]
                
                if predicted_performance > best_score:
                    best_score = predicted_performance
                    best_config.concurrent_requests = concurrent
                    best_config.request_delay_ms = delay
        
        return best_config
```

## :arrow_right: Next Steps

- Learn troubleshooting techniques in [Troubleshooting](troubleshooting.md)
- Understand legal considerations in [Legal Notice](../legal/legal-notice.md)
- Get support in [Support](../legal/support.md)
