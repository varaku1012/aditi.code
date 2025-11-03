#!/bin/bash

echo "🧹 Cleaning Steering Context Generator artifacts..."

# Function to get directory size
get_size() {
    du -sh "$1" 2>/dev/null | cut -f1
}

# Show what will be cleaned
echo ""
echo "Artifacts to clean:"
echo "  Archives: $(get_size .claude/memory/archives)"
echo "  Logs: $(get_size .claude/logs)"
echo "  Cache: $(get_size .claude/steering/v2.0/cache)"

# Confirm with user (if interactive)
if [ -t 0 ]; then
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cleanup cancelled"
        exit 0
    fi
fi

# Archive current run before cleaning
if [ -d ".claude/steering" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    echo "Archiving current context to .claude/memory/archives/backup_${TIMESTAMP}..."
    mkdir -p .claude/memory/archives/backup_${TIMESTAMP}
    cp -r .claude/steering/*.md .claude/memory/archives/backup_${TIMESTAMP}/ 2>/dev/null
fi

# Clean archives older than 7 days
echo "Cleaning old archives (>7 days)..."
find .claude/memory/archives -type d -mtime +7 -exec rm -rf {} + 2>/dev/null

# Clean old logs
echo "Cleaning old logs (>30 days)..."
find .claude/logs -type f -mtime +30 -delete 2>/dev/null

# Clean cache
echo "Cleaning cache..."
rm -rf .claude/steering/v2.0/cache/* 2>/dev/null

# Clean temporary files
echo "Cleaning temporary files..."
find .claude/memory -name "*.tmp" -delete 2>/dev/null
find .claude/memory -name "*.lock" -delete 2>/dev/null

# Show final sizes
echo ""
echo "Cleanup complete!"
echo "Current usage:"
echo "  Archives: $(get_size .claude/memory/archives)"
echo "  Logs: $(get_size .claude/logs)"
echo "  Total: $(get_size .claude)"
