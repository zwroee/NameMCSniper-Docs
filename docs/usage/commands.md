# Command Reference

Complete reference for all NameMC Sniper commands and options.

## :computer: Command Syntax

```bash
python Main.py [COMMAND] [OPTIONS]
```

## :star: Core Commands

### `snipe`

Start the username sniping process.

```bash
python Main.py snipe [OPTIONS]
```

**Options:**

| Option | Short | Type | Description | Default |
|--------|-------|------|-------------|---------|
| `--username` | `-u` | string | Target username to snipe | From config |
| `--token` | `-t` | string | Minecraft bearer token | From config |
| `--config` | `-c` | string | Path to config file | `config.yaml` |
| `--dry-run` | | flag | Test mode without actual sniping | False |
| `--debug` | | flag | Enable debug logging | False |
| `--no-notifications` | | flag | Disable Discord notifications | False |
| `--start-immediately` | | flag | Skip waiting, start sniping now | False |

**Examples:**

```bash
# Basic snipe with config file
python Main.py snipe

# Override username and token
python Main.py snipe -u "NewUsername" -t "eyJ0eXAi..."

# Test run without actual sniping
python Main.py snipe --dry-run

# Use custom config file
python Main.py snipe -c "production.yaml"

# Debug mode with immediate start
python Main.py snipe --debug --start-immediately
```

### `config-create`

Create a default configuration file.

```bash
python Main.py config-create [OPTIONS]
```

**Options:**

| Option | Short | Type | Description | Default |
|--------|-------|------|-------------|---------|
| `--output` | `-o` | string | Output file path | `config.yaml` |
| `--overwrite` | | flag | Overwrite existing file | False |
| `--template` | `-t` | string | Template type | `default` |

**Examples:**

```bash
# Create default config
python Main.py config-create

# Create with custom name
python Main.py config-create -o "my-config.yaml"

# Overwrite existing config
python Main.py config-create --overwrite

# Create from template
python Main.py config-create -t "high-performance"
```

### `config-validate`

Validate configuration file settings.

```bash
python Main.py config-validate [OPTIONS]
```

**Options:**

| Option | Short | Type | Description | Default |
|--------|-------|------|-------------|---------|
| `--config` | `-c` | string | Config file to validate | `config.yaml` |
| `--strict` | | flag | Enable strict validation | False |
| `--fix` | | flag | Attempt to fix issues | False |

**Examples:**

```bash
# Validate default config
python Main.py config-validate

# Validate custom config
python Main.py config-validate -c "custom.yaml"

# Strict validation with auto-fix
python Main.py config-validate --strict --fix
```

### `test-proxies`

Test proxy connections and performance.

```bash
python Main.py test-proxies [OPTIONS]
```

**Options:**

| Option | Short | Type | Description | Default |
|--------|-------|------|-------------|---------|
| `--config` | `-c` | string | Config file with proxy settings | `config.yaml` |
| `--timeout` | `-t` | integer | Test timeout in seconds | 10 |
| `--verbose` | `-v` | flag | Show detailed test results | False |
| `--export` | `-e` | string | Export results to file | None |

**Examples:**

```bash
# Test all proxies from config
python Main.py test-proxies

# Test with custom timeout
python Main.py test-proxies -t 5

# Verbose output with export
python Main.py test-proxies -v -e "proxy-test-results.json"
```

## :information_source: Information Commands

### `version`

Display version information.

```bash
python Main.py version [OPTIONS]
```

**Options:**

| Option | Short | Type | Description |
|--------|-------|------|-------------|
| `--detailed` | `-d` | flag | Show detailed version info |
| `--json` | | flag | Output in JSON format |

**Examples:**

```bash
# Basic version info
python Main.py version

# Detailed version with dependencies
python Main.py version --detailed

# JSON output for scripts
python Main.py version --json
```

### `help`

Show help information.

```bash
python Main.py help [COMMAND]
```

**Examples:**

```bash
# General help
python Main.py help

# Help for specific command
python Main.py help snipe
python Main.py help config-create
```

## :wrench: Utility Commands

### `generate-token`

Helper to generate bearer tokens (if implemented).

```bash
python Main.py generate-token [OPTIONS]
```

**Options:**

| Option | Short | Type | Description |
|--------|-------|------|-------------|
| `--interactive` | `-i` | flag | Interactive token generation |
| `--save` | `-s` | flag | Save token to config |

### `check-username`

Check username availability and drop time.

```bash
python Main.py check-username [USERNAME] [OPTIONS]
```

**Options:**

| Option | Short | Type | Description |
|--------|-------|------|-------------|
| `--json` | | flag | Output in JSON format |
| `--watch` | `-w` | flag | Continuously monitor |

**Examples:**

```bash
# Check single username
python Main.py check-username "DesiredName"

# Monitor continuously
python Main.py check-username "DesiredName" --watch

# JSON output
python Main.py check-username "DesiredName" --json
```

## :globe_with_meridians: Global Options

These options work with any command:

| Option | Description | Example |
|--------|-------------|---------|
| `--help` | Show command help | `python Main.py snipe --help` |
| `--quiet` | Suppress non-error output | `python Main.py snipe --quiet` |
| `--verbose` | Increase output verbosity | `python Main.py snipe --verbose` |
| `--log-file` | Custom log file path | `python Main.py snipe --log-file "custom.log"` |
| `--no-color` | Disable colored output | `python Main.py snipe --no-color` |

## :gear: Environment Variables

Override settings using environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `NAMEMC_CONFIG` | Default config file path | `export NAMEMC_CONFIG="prod.yaml"` |
| `NAMEMC_TOKEN` | Default bearer token | `export NAMEMC_TOKEN="eyJ0eXAi..."` |
| `NAMEMC_DEBUG` | Enable debug mode | `export NAMEMC_DEBUG="true"` |
| `NAMEMC_LOG_LEVEL` | Set log level | `export NAMEMC_LOG_LEVEL="DEBUG"` |

## :memo: Configuration File Options

When using config files, these settings are available:

### Snipe Section
```yaml
snipe:
  target_username: "string"           # Username to snipe
  bearer_token: "string"              # Authentication token
  start_sniping_at_seconds: 30        # Seconds before drop to start
  max_snipe_attempts: 100             # Maximum attempts
  request_delay_ms: 25                # Delay between requests
  concurrent_requests: 10             # Concurrent request count
  use_multiple_threads: true          # Enable threading
```

### Proxy Section
```yaml
proxy:
  enabled: true                       # Enable proxy usage
  proxies: ["http://ip:port"]         # Proxy list
  rotation_enabled: true              # Enable rotation
  timeout: 10                         # Connection timeout
  max_retries: 3                      # Retry attempts
```

### Discord Section
```yaml
discord:
  enabled: true                       # Enable notifications
  webhook_url: "string"               # Webhook URL
  bot_token: "string"                 # Bot token (alternative)
  channel_id: "string"                # Channel ID (for bot)
  mention_role_id: "string"           # Role to mention
  embed_color: 65280                  # Embed color (decimal)
```

## :warning: Exit Codes

NameMC Sniper uses these exit codes:

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Configuration error |
| 3 | Authentication error |
| 4 | Network error |
| 5 | Proxy error |
| 6 | Discord error |
| 130 | Interrupted by user (Ctrl+C) |

## :bulb: Advanced Usage Examples

### Scripted Deployment

```bash
#!/bin/bash
# Automated sniper setup script

# Validate environment
python Main.py config-validate --strict || exit 1
python Main.py test-proxies --timeout 5 || exit 1

# Start sniping with logging
python Main.py snipe \
  --username "$TARGET_USERNAME" \
  --token "$BEARER_TOKEN" \
  --log-file "snipe-$(date +%Y%m%d).log" \
  --verbose
```

### Multiple Username Monitoring

```bash
# Monitor multiple usernames (requires scripting)
for username in "Name1" "Name2" "Name3"; do
  python Main.py check-username "$username" --json >> "availability.json"
done
```

### Production Configuration

```bash
# Production snipe with all safety checks
python Main.py config-validate --strict --fix
python Main.py test-proxies --export "proxy-status.json"
python Main.py snipe \
  --config "production.yaml" \
  --no-notifications \
  --log-file "/var/log/namemc-sniper.log"
```

## :arrow_right: Next Steps

- Learn Discord setup in [Discord Setup](discord-setup.md)
- Configure proxies in [Proxy Setup](proxy-setup.md)
- Optimize performance in [Performance Optimization](../advanced/performance.md)
