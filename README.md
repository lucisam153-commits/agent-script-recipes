# SquireX Security Test Repository

This repository contains intentionally vulnerable Salesforce Agentforce/Apex code patterns to test the SquireX security scanner.

## Vulnerable Patterns Included:

1. **Template Context Poisoning**: Unescaped AI outputs in Prompt Template XML
2. **System Context Escalation**: Autonomous Agent triggering SystemModeWithoutSharing Flow
3. **Excessive Agency Prevention**: Missing manual confirmation for state-modifying actions
4. **Variable Injection in DML**: Dynamically bound AI {!Variables} in SOQL/Filters
5. **Schema Drift**: Mismatches between OpenAPI schemas and metadata

## Test Goals:
- Run SquireX scan locally and in GitHub Actions
- Generate SARIF reports for GitHub Security
- Validate SquireX's detection capabilities
- Identify any false positives/negatives