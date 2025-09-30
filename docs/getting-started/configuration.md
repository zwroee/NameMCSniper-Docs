# Configuration

Configure NameMC Sniper for optimal performance with the `config.yaml` file.

## :wrench: Configuration File Structure

The configuration file is organized into several sections:

```yaml
proxy:
  enabled: true
  proxies:
    - "http://proxy1:port"
    - "http://proxy2:port"
  rotation_enabled: true
  timeout: 10
  max_retries: 3

discord:
  enabled: true
  webhook_url: "https://discord.com/api/webhooks/..."
  bot_token: ""  # Optional: Use bot instead of webhook
  channel_id: ""  # Required if using bot
  mention_role_id: "123456789"  # Optional: Role to mention
  embed_color: 65280

snipe:
  target_username: "DesiredUsername"
  bearer_token: "your_minecraft_bearer_token"
  start_sniping_at_seconds: 30
  max_snipe_attempts: 100
  request_delay_ms: 25
  concurrent_requests: 10
  use_multiple_threads: true

notifications:
  intervals:
    - 86400  # 24 hours
    - 43200  # 12 hours
    - 21600  # 6 hours
    - 7200   # 2 hours
    - 3600   # 1 hour
    - 1800   # 30 minutes
    - 300    # 5 minutes
    - 60     # 1 minute
    - 30     # 30 seconds

debug_mode: false
log_level: "INFO"
```

## :gear: Configuration Sections

### Proxy Settings

Configure proxy rotation for improved performance and reliability:

| Setting | Type | Description |
|---------|------|-------------|
| `enabled` | boolean | Enable/disable proxy usage |
| `proxies` | list | List of proxy URLs |
| `rotation_enabled` | boolean | Enable proxy rotation |
| `timeout` | integer | Proxy timeout in seconds |
| `max_retries` | integer | Maximum retry attempts per proxy |

!!! example "Proxy Formats"
    - `http://ip:port`
    - `http://username:password@ip:port`
    - `https://ip:port`
    - `socks5://ip:port`

### Discord Integration

Set up Discord notifications for real-time updates:

| Setting | Type | Description |
|---------|------|-------------|
| `enabled` | boolean | Enable Discord notifications |
| `webhook_url` | string | Discord webhook URL (recommended) |
| `bot_token` | string | Discord bot token (alternative) |
| `channel_id` | string | Channel ID (required for bot) |
| `mention_role_id` | string | Role ID to mention (optional) |
| `embed_color` | integer | Embed color (decimal format) |

### Snipe Settings

Core sniping configuration:

| Setting | Type | Description |
|---------|------|-------------|
| `target_username` | string | Username to snipe |
| `bearer_token` | string | Minecraft bearer token |
| `start_sniping_at_seconds` | integer | Seconds before drop to start |
| `max_snipe_attempts` | integer | Maximum snipe attempts |
| `request_delay_ms` | integer | Delay between requests (ms) |
| `concurrent_requests` | integer | Number of concurrent requests |
| `use_multiple_threads` | boolean | Enable multi-threading |

### Notification Intervals

Customize when to receive countdown notifications:

```yaml
notifications:
  intervals:
    - 86400  # 24 hours before drop
    - 43200  # 12 hours before drop
    - 21600  # 6 hours before drop
    - 7200   # 2 hours before drop
    - 3600   # 1 hour before drop
    - 1800   # 30 minutes before drop
    - 300    # 5 minutes before drop
    - 60     # 1 minute before drop
    - 30     # 30 seconds before drop
```

## :bulb: Configuration Tips

### Performance Optimization

**High-Speed Setup**:
```yaml
snipe:
  request_delay_ms: 10      # Lower delay = faster requests
  concurrent_requests: 20   # More concurrent requests
  use_multiple_threads: true
```

**Conservative Setup**:
```yaml
snipe:
  request_delay_ms: 50      # Higher delay = less aggressive
  concurrent_requests: 5    # Fewer concurrent requests
  use_multiple_threads: false
```

### Proxy Recommendations

- Use **high-quality residential proxies** for best results
- Test proxies regularly with `python Main.py test-proxies`
- Rotate proxies to avoid rate limiting
- Use proxies close to Minecraft servers geographically

### Discord Setup Priority

1. **Webhook** (Recommended) - Easier setup, reliable
2. **Bot** - More features but requires more setup

## :warning: Important Notes

!!! warning "Bearer Token Security"
    Never share your bearer token or commit it to version control. Consider using environment variables:
    
    ```yaml
    snipe:
      bearer_token: "${MINECRAFT_BEARER_TOKEN}"
    ```

!!! info "Rate Limiting"
    Be careful with aggressive settings. Too many requests too quickly may result in rate limiting or IP bans.

## :white_check_mark: Validation

Always validate your configuration after making changes:

```bash
python Main.py config-validate
```

## :arrow_right: Next Steps

Once configured, learn how to get your bearer token in the [Authentication](authentication.md) guide.
