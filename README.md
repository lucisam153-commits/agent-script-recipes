# SquireX Security Test Repository

This repository contains intentionally vulnerable Salesforce Agentforce/Apex code patterns to test the SquireX security scanner.

## Current Status
- **Last Updated**: 2026-05-20
- **Primary CI**: GitHub Actions with SquireX security scanning
- **Status**: SquireX binary URL needs update - workflow includes fallback mock binary
- **Testing Focus**: Agentforce/Apex vulnerability detection patterns

## Recent Changes
- Updated GitHub Actions workflow with fallback download logic
- Added graceful degradation when SquireX binary is unavailable
- Maintains test patterns for 22 security rules

## Quick Start
1. Push to `main` branch triggers security scan
2. Manual trigger available via GitHub Actions UI
3. Results available as SARIF files and GitHub Security alerts

## Test Patterns
- Template Context Poisoning (AGENTFORCE-1.1)
- System Context Escalation (AGENTFORCE-1.2)
- Excessive Agency Prevention (AGENTFORCE-1.3)
- Variable Injection (AGENTFORCE-1.4)
- SOQL Injection detection

---

*OpenClaw GitHub integration demo executed: 2026-05-20*
