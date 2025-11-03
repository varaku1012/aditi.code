---
description: Export steering context to different formats (JSON, YAML, HTML, PDF - Coming Soon)
---

# Steering Context Generator - Export

Export generated documentation to different formats.

## Quick Start

```bash
/steering-export --format json
```

## Supported Formats (v1.0)

### Markdown (Default)

Already generated in `.claude/steering/*.md`

### JSON

Export as structured JSON:

```bash
# Export all documents
cat > .claude/steering/export/context.json << 'EOF'
{
  "version": "1.0.0",
  "generated": "$(date -Iseconds)",
  "project": {
    "name": "$(basename $(pwd))",
    "tech_stack": "$(jq -r '.tech_stack' .claude/memory/orchestration/detection.json 2>/dev/null || echo 'Unknown')"
  },
  "documents": {
    "architecture": "$(cat .claude/steering/ARCHITECTURE.md | base64)",
    "ai_context": "$(cat .claude/steering/AI_CONTEXT.md | base64)",
    "codebase_guide": "$(cat .claude/steering/CODEBASE_GUIDE.md | base64)"
  }
}
EOF

echo "Exported to: .claude/steering/export/context.json"
```

### Plain Text

Strip markdown formatting:

```bash
# Convert markdown to plain text
for file in .claude/steering/*.md; do
  BASENAME=$(basename "$file" .md)
  pandoc "$file" -t plain -o ".claude/steering/export/${BASENAME}.txt" 2>/dev/null || \
  sed 's/[#*`]//g' "$file" > ".claude/steering/export/${BASENAME}.txt"
done

echo "Exported to: .claude/steering/export/*.txt"
```

## Coming Soon (v1.1+)

### HTML

```bash
# Will generate interactive HTML documentation
/steering-export --format html
```

### PDF

```bash
# Will generate PDF documentation
/steering-export --format pdf
```

### YAML

```bash
# Will generate YAML configuration
/steering-export --format yaml
```

## Export Directory

Exports are saved to:
```
.claude/steering/export/
├── context.json
├── ARCHITECTURE.txt
├── AI_CONTEXT.txt
└── ...
```

## Use Cases

### Share with Team

```bash
# Export and compress
/steering-export --format json
tar -czf context-export.tar.gz .claude/steering/export/
```

### CI/CD Integration

```bash
# Export as JSON for automated processing
/steering-export --format json
cat .claude/steering/export/context.json | jq '.documents.architecture'
```

### Documentation Website

```bash
# Convert to HTML (v1.1+)
/steering-export --format html
# Publish to docs site
```

## Troubleshooting

### Export fails

Ensure documents are generated:
```bash
/steering-status
```

If missing, generate first:
```bash
/steering-generate
```

---

**Share your context:** Export with `/steering-export`
