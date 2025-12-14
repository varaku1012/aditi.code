---
description: Generate comprehensive documentation for the entire project
argument-hint: [--format md|html|pdf] [--output dir]
allowed-tools: Read, Write, Glob, Grep
---

# Generate Project Documentation

Create comprehensive documentation for the entire project.

## Usage

```
/docs-generate                      # Generate all docs
/docs-generate --format html        # HTML output
/docs-generate --output docs/       # Custom output directory
/docs-generate --sections api,arch  # Specific sections only
```

## Generated Sections

### 1. Project Overview
- Project description
- Key features
- Technology stack
- Quick start guide

### 2. Architecture Documentation
- System architecture diagram (ASCII)
- Component descriptions
- Data flow diagrams
- Design decisions

### 3. API Reference
- All public functions/classes
- Parameters and return types
- Usage examples
- Error handling

### 4. User Guide
- Installation instructions
- Configuration options
- Common use cases
- Troubleshooting

### 5. Developer Guide
- Development setup
- Code structure
- Contributing guidelines
- Testing instructions

## Output Structure

```
docs/
├── index.md                 # Main entry point
├── getting-started.md       # Quick start guide
├── architecture/
│   ├── overview.md         # System architecture
│   ├── pipelines.md        # Pipeline documentation
│   └── agents.md           # Agent system docs
├── api/
│   ├── pipelines.md        # Pipeline API reference
│   ├── agents.md           # Agent API reference
│   ├── tools.md            # Tools API reference
│   └── interfaces.md       # Data models reference
├── guides/
│   ├── configuration.md    # Config guide
│   ├── customization.md    # Customization guide
│   └── troubleshooting.md  # Troubleshooting guide
└── development/
    ├── setup.md            # Dev environment setup
    ├── testing.md          # Testing guide
    └── contributing.md     # Contribution guidelines
```

## Configuration

In `docs.yaml`:
```yaml
project:
  name: InfiniteMedia
  description: Multi-agent video generation framework
  version: 1.0.0

output:
  format: markdown
  directory: ./docs
  include_source_links: true

sections:
  - overview
  - architecture
  - api
  - guides
  - development

exclude_patterns:
  - "tests/*"
  - "*.pyc"
  - "__pycache__"
```

## Format Options

### Markdown (default)
- GitHub-compatible
- Easy to version control
- Renders in most viewers

### HTML
- Static site generation
- Searchable
- Interactive navigation

### PDF
- Printable documentation
- Offline access
- Professional distribution
