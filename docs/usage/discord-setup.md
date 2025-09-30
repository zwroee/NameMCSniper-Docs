# Discord Setup

Configure Discord notifications to receive real-time updates about your sniping progress.

## :loudspeaker: Notification Types

NameMC Sniper sends several types of Discord notifications:

- **Countdown alerts** (24h, 12h, 6h, 2h, 1h, 30m, 5m, 1m, 30s before drop)
- **Snipe start notification** (when sniping begins)
- **Success/failure results** (final outcome)
- **Error alerts** (proxy failures, token issues, etc.)

## :gear: Setup Methods

You can use either **webhooks** (recommended) or **Discord bots** for notifications.

### Method 1: Webhook Setup (Recommended)

Webhooks are easier to set up and more reliable for notifications.

#### Step 1: Create a Webhook

1. **Open Discord** and go to your server
2. **Right-click the channel** where you want notifications
3. **Select "Edit Channel"**
4. **Go to "Integrations" tab**
5. **Click "Create Webhook"**
6. **Name your webhook** (e.g., "NameMC Sniper")
7. **Copy the webhook URL**

#### Step 2: Configure Webhook

Add the webhook URL to your `config.yaml`:

```yaml
discord:
  enabled: true
  webhook_url: "https://discord.com/api/webhooks/1234567890/abcdef..."
  bot_token: ""  # Leave empty when using webhook
  channel_id: ""  # Leave empty when using webhook
  mention_role_id: "123456789012345678"  # Optional: Role ID to mention
  embed_color: 65280  # Green color (decimal)
```

#### Step 3: Test Webhook

```bash
python Main.py test-discord-webhook
```

### Method 2: Discord Bot Setup

Bots provide more features but require more setup.

#### Step 1: Create Discord Application

1. **Go to** [Discord Developer Portal](https://discord.com/developers/applications)
2. **Click "New Application"**
3. **Name your application** (e.g., "NameMC Sniper Bot")
4. **Go to "Bot" section**
5. **Click "Add Bot"**
6. **Copy the bot token**

#### Step 2: Add Bot to Server

1. **Go to "OAuth2" > "URL Generator"**
2. **Select scopes**: `bot`
3. **Select permissions**: `Send Messages`, `Embed Links`, `Mention Everyone`
4. **Copy the generated URL** and open it
5. **Add bot to your server**

#### Step 3: Configure Bot

```yaml
discord:
  enabled: true
  webhook_url: ""  # Leave empty when using bot
  bot_token: "your_bot_token_here"
  channel_id: "123456789012345678"  # Channel ID for notifications
  mention_role_id: "123456789012345678"  # Optional: Role ID to mention
  embed_color: 65280  # Green color (decimal)
```

#### Step 4: Get Channel ID

1. **Enable Developer Mode** in Discord (User Settings > Advanced > Developer Mode)
2. **Right-click the channel** where you want notifications
3. **Select "Copy ID"**
4. **Paste the ID** into `channel_id` in config

## :art: Customization Options

### Embed Colors

Choose notification colors (decimal format):

| Color | Decimal | Hex | Use Case |
|-------|---------|-----|----------|
| Green | `65280` | `#00FF00` | Success notifications |
| Red | `16711680` | `#FF0000` | Error notifications |
| Yellow | `16776960` | `#FFFF00` | Warning notifications |
| Blue | `255` | `#0000FF` | Info notifications |
| Purple | `8388736` | `#800080` | Countdown notifications |

### Role Mentions

To mention a role in notifications:

1. **Create or find a role** in your Discord server
2. **Get the role ID**:
   - Type `\@RoleName` in Discord
   - Copy the ID from the result: `<@&123456789012345678>`
   - Use just the numbers: `123456789012345678`
3. **Add to config**:
   ```yaml
   discord:
     mention_role_id: "123456789012345678"
   ```

### Custom Messages

Advanced users can customize notification messages by modifying the source code or using templates:

```yaml
discord:
  templates:
    countdown: "⏰ **{time_remaining}** until {username} drops!"
    snipe_start: "🎯 Starting snipe attempts for **{username}**"
    success: "🎉 Successfully sniped **{username}**!"
    failure: "❌ Failed to snipe **{username}**"
```

## :bell: Notification Examples

### Countdown Notification
```
⏰ Username Drop Alert

🎯 Target: ExampleUser
⏱️ Time Remaining: 2 hours
📅 Drop Time: 2024-01-15 14:30:00 UTC
🔗 NameMC: https://namemc.com/profile/ExampleUser

@SnipeRole Get ready!
```

### Success Notification
```
🎉 Snipe Successful!

✅ Username: ExampleUser
⚡ Attempts: 47
⏱️ Duration: 2.3 seconds
🌐 Proxy Used: proxy1.example.com
📊 Success Rate: 100%

Congratulations! 🎊
```

### Error Notification
```
❌ Snipe Failed

🎯 Username: ExampleUser
❌ Reason: Rate limited
🔄 Attempts Made: 100
⏱️ Duration: 30 seconds
🌐 Proxies Tried: 5

Check logs for details.
```

## :wrench: Advanced Configuration

### Multiple Webhooks

Send different notification types to different channels:

```yaml
discord:
  enabled: true
  webhooks:
    countdown: "https://discord.com/api/webhooks/.../countdown"
    results: "https://discord.com/api/webhooks/.../results"
    errors: "https://discord.com/api/webhooks/.../errors"
```

### Conditional Notifications

Control when notifications are sent:

```yaml
discord:
  enabled: true
  webhook_url: "https://discord.com/api/webhooks/..."
  conditions:
    send_countdown: true
    send_errors: true
    send_success: true
    send_failure: true
    min_time_remaining: 3600  # Only send if >1 hour remaining
```

### Rate Limiting

Prevent Discord rate limiting:

```yaml
discord:
  enabled: true
  webhook_url: "https://discord.com/api/webhooks/..."
  rate_limit:
    max_messages_per_minute: 5
    burst_limit: 2
    cooldown_seconds: 60
```

## :white_check_mark: Testing Your Setup

### Test Webhook

```bash
# Test webhook connection
curl -X POST "YOUR_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d '{"content": "Test message from NameMC Sniper!"}'
```

### Test Bot

```bash
# Test bot with dry run
python Main.py snipe --dry-run --debug
```

### Validate Configuration

```bash
# Check Discord configuration
python Main.py config-validate --section discord
```

## :exclamation: Troubleshooting

### Common Issues

**Webhook not working:**
- Verify webhook URL is correct and complete
- Check if webhook was deleted from Discord
- Ensure channel permissions allow webhooks

**Bot not responding:**
- Verify bot token is correct
- Check if bot has necessary permissions
- Ensure bot is online and in the server

**No notifications received:**
- Check Discord notification settings
- Verify channel ID is correct
- Test with a simple message first

**Rate limiting errors:**
- Reduce notification frequency
- Use fewer concurrent requests
- Implement rate limiting in config

### Debug Mode

Enable debug mode to see detailed Discord communication:

```bash
python Main.py snipe --debug
```

Look for Discord-related log entries:
```
[DEBUG] Discord webhook: Sending countdown notification
[DEBUG] Discord response: 200 OK
[ERROR] Discord webhook failed: 429 Too Many Requests
```

## :shield: Security Considerations

### Webhook Security
- **Don't share webhook URLs** publicly
- **Regenerate webhooks** if compromised
- **Use HTTPS** webhooks only

### Bot Security
- **Keep bot tokens private**
- **Use minimal permissions**
- **Regularly rotate tokens**
- **Monitor bot activity**

### Channel Security
- **Use private channels** for sensitive notifications
- **Limit channel access** to trusted users
- **Avoid logging sensitive data** in notifications

## :arrow_right: Next Steps

- Configure proxy settings in [Proxy Setup](proxy-setup.md)
- Optimize performance in [Performance Optimization](../advanced/performance.md)
- Learn troubleshooting in [Troubleshooting](../advanced/troubleshooting.md)
