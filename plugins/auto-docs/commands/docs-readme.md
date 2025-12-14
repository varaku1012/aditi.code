---
description: Generate or update README.md from project analysis
argument-hint: [--update] [--sections]
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Generate README

Create or update README.md based on project analysis.

## Usage

```
/docs-readme                        # Generate new README
/docs-readme --update               # Update existing README
/docs-readme --sections features,install  # Specific sections
```

## README Sections

### 1. Header
- Project name and badges
- One-line description
- Key highlights

### 2. Features
- Core capabilities
- Unique selling points
- Technology highlights

### 3. Quick Start
- Installation steps
- Basic usage example
- Minimum requirements

### 4. Installation
- Prerequisites
- Step-by-step installation
- Configuration

### 5. Usage
- Common use cases
- Code examples
- Configuration options

### 6. Architecture
- System overview
- Key components
- Data flow

### 7. API Reference
- Key functions/classes
- Link to full docs

### 8. Contributing
- How to contribute
- Development setup
- Code standards

### 9. License
- License type
- Copyright notice

## Generated README Template

```markdown
# ProjectName

[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Python](https://img.shields.io/badge/python-3.12+-blue.svg)]()

Brief description of what the project does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Quick Start

```bash
# Install
pip install project-name

# Run
python main.py --input "your input"
```

## Installation

### Prerequisites
- Python 3.12+
- Required API keys

### Steps
1. Clone the repository
2. Install dependencies
3. Configure API keys

## Usage

### Basic Example
```python
from project import Pipeline

pipeline = Pipeline(config)
result = await pipeline.run(input_data)
```

## Architecture

```
project/
├── pipelines/     # Processing pipelines
├── agents/        # AI agents
├── tools/         # External integrations
└── interfaces/    # Data models
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.
```

## Update Mode

With `--update`:
- Preserves custom content
- Updates generated sections
- Adds missing sections
- Maintains formatting

Sections marked with `<!-- AUTO-GENERATED -->` are updated.
Custom sections are preserved.

## Configuration

In `readme.yaml`:
```yaml
sections:
  - header
  - features
  - quick_start
  - installation
  - usage
  - architecture
  - contributing
  - license

badges:
  - license
  - python_version
  - tests
  - coverage

preserve_custom: true
```
