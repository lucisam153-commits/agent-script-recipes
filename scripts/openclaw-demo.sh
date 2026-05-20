#!/bin/bash
# OpenClaw Demo Script
# Created: 2026-05-20
# Demonstrates automation capabilities via OpenClaw

echo "=== OpenClaw GitHub Integration Demo ==="
echo "Repository: agent-script-recipes"
echo "Timestamp: $(date)"
echo ""

# Show repository info
echo "1. Repository Information:"
echo "   - Current branch: $(git branch --show-current)"
echo "   - Latest commit: $(git log --oneline -1)"
echo ""

# Show recent changes
echo "2. Recent Changes by OpenClaw:"
git log --oneline --grep="OpenClaw" -5 2>/dev/null || echo "   No OpenClaw-specific commits found"
echo ""

# List demo files
echo "3. Demo Files Created:"
find . -name "*demo*" -o -name "*DEMO*" | head -10
echo ""

# Show workflow status
echo "4. CI/CD Status:"
echo "   - GitHub Actions workflows: $(find .github/workflows -name "*.yml" -o -name "*.yaml" | wc -l)"
echo "   - Last workflow run: Check GitHub Actions UI"
echo ""

echo "=== Demo Complete ==="
echo ""
echo "This script demonstrates that OpenClaw can:"
echo "✅ Create and execute shell scripts"
echo "✅ Analyze git repository state"
echo "✅ Document automation processes"
echo "✅ Integrate with existing CI/CD pipelines"