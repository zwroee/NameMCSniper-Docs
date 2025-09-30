# NameMC Sniper Documentation

This repository contains the complete documentation for NameMC Sniper, built with MkDocs and Material theme.

## 🚀 Quick Start

### Prerequisites

- Python 3.8 or higher
- pip package manager

### Installation

1. **Clone this repository:**
   ```bash
   git clone <repository-url>
   cd NameMcSniper-Docs
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Serve locally:**
   ```bash
   mkdocs serve
   ```

4. **Open in browser:**
   Navigate to `http://127.0.0.1:8000`

## 📚 Documentation Structure

```
docs/
├── index.md                           # Home page
├── getting-started/
│   ├── installation.md               # Installation guide
│   ├── configuration.md              # Configuration setup
│   └── authentication.md             # Bearer token setup
├── usage/
│   ├── basic-usage.md                # Essential commands
│   ├── commands.md                   # Complete command reference
│   ├── discord-setup.md              # Discord notifications
│   └── proxy-setup.md                # Proxy configuration
├── advanced/
│   ├── how-it-works.md               # Internal mechanics
│   ├── performance.md                # Performance optimization
│   └── troubleshooting.md            # Common issues & solutions
└── legal/
    ├── legal-notice.md               # Legal information
    └── support.md                    # Support channels
```

## 🛠️ Development

### Building the Documentation

```bash
# Serve with live reload (development)
mkdocs serve

# Build static site
mkdocs build

# Deploy to GitHub Pages
mkdocs gh-deploy
```

### Making Changes

1. **Edit Markdown files** in the `docs/` directory
2. **Preview changes** with `mkdocs serve`
3. **Test build** with `mkdocs build`
4. **Commit and push** changes

### Adding New Pages

1. **Create new `.md` file** in appropriate directory
2. **Add to navigation** in `mkdocs.yml`:
   ```yaml
   nav:
     - New Section:
       - New Page: path/to/new-page.md
   ```

## 🎨 Customization

### Theme Configuration

The site uses Material for MkDocs with custom configuration:

- **Color scheme:** Green primary, light green accent
- **Features:** Navigation tabs, search, code copy
- **Extensions:** Syntax highlighting, admonitions, emojis

### Modifying Styles

To customize the appearance:

1. **Edit `mkdocs.yml`** for theme settings
2. **Add custom CSS** in `docs/stylesheets/`
3. **Modify templates** in `docs/overrides/`

## 📝 Content Guidelines

### Writing Style

- **Clear and concise** explanations
- **Step-by-step instructions** for procedures
- **Code examples** with syntax highlighting
- **Screenshots** where helpful
- **Consistent formatting** throughout

### Markdown Features

The documentation supports:

- **Admonitions** for notes, warnings, tips
- **Code blocks** with syntax highlighting
- **Tables** for structured information
- **Emoji** for visual appeal
- **Mermaid diagrams** for flowcharts

### Example Admonitions

```markdown
!!! info "Information"
    This is an informational note.

!!! warning "Warning"
    This is a warning message.

!!! tip "Pro Tip"
    This is a helpful tip.
```

## 🚀 Deployment

### GitHub Pages

Automatic deployment to GitHub Pages:

```bash
# Deploy to gh-pages branch
mkdocs gh-deploy
```

### Manual Deployment

1. **Build the site:**
   ```bash
   mkdocs build
   ```

2. **Upload `site/` directory** to your web server

### Docker Deployment

```dockerfile
FROM nginx:alpine
COPY site/ /usr/share/nginx/html/
EXPOSE 80
```

## 📝 Documentation

This documentation is provided as-is for educational purposes.

## 📋 TODO

- [ ] Add more screenshots and visual examples
- [ ] Create video tutorials
- [ ] Add search functionality improvements
- [ ] Implement dark/light theme toggle
- [ ] Add print-friendly CSS
- [ ] Create PDF export option

## 🔧 Troubleshooting

### Common Issues

**MkDocs not found:**
```bash
pip install mkdocs
```

**Theme not loading:**
```bash
pip install mkdocs-material
```

**Build errors:**
```bash
# Check for syntax errors in mkdocs.yml
mkdocs build --verbose
```

**Live reload not working:**
```bash
# Try different port
mkdocs serve --dev-addr=127.0.0.1:8001
```

### Getting Help

- **Check MkDocs documentation:** https://www.mkdocs.org/
- **Material theme docs:** https://squidfunk.github.io/mkdocs-material/
- **Create an issue** in this repository

## 📄 License

This documentation is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **MkDocs** - Static site generator
- **Material for MkDocs** - Beautiful theme
- **Python Markdown** - Markdown processing
- **Contributors** - Everyone who helped improve this documentation

---

**Documentation for NameMC Sniper** - A powerful CLI Minecraft username sniper tool.
