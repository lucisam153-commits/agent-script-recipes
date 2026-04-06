# SquireX Security Test Plan

## Test Objectives
1. Validate SquireX detection of Agentforce capability exploits
2. Test SARIF report generation for GitHub Security
3. Identify false positives/negatives in SquireX scanning
4. Evaluate CI/CD integration capabilities

## Vulnerabilities Included

### Category 1: Template Context Poisoning
- **Location**: `DangerousAgent.agent` - PromptTemplate without outputEscaping
- **Description**: Unescaped AI outputs in Prompt Template XML blocks
- **Expected Detection**: AGENTFORCE-1.1 (Template Context Poisoning)

### Category 2: System Context Escalation  
- **Location**: `SystemModeDangerFlow.flow-meta.xml` - runInMode="SystemModeWithoutSharing"
- **Description**: Autonomous Agent triggering Flow in SystemModeWithoutSharing
- **Expected Detection**: AGENTFORCE-1.2 (System Context Escalation)

### Category 3: Excessive Agency Prevention
- **Location**: `DangerousAgent.agent` - confirmationRequired="false" on state-modifying action
- **Description**: Missing manual confirmation for state-modifying actions
- **Expected Detection**: AGENTFORCE-1.3 (Excessive Agency Prevention)

### Category 4: Variable Injection in DML
- **Location**: 
  - `DangerousAgent.agent` - {!currentUser.Id} in genAiFunction parameter
  - `SystemModeDangerFlow.flow-meta.xml` - {!aiVariable.userId} in filter
- **Description**: Dynamically bound AI {!Variables} within SOQL/Filters
- **Expected Detection**: AGENTFORCE-1.4 (Variable Injection)

### Category 5: SOQL Injection
- **Location**: `DangerousApexController.cls` - searchAccounts method
- **Description**: Direct string concatenation in SOQL query
- **Expected Detection**: APEX-1.1 (SOQL Injection)

### Category 6: ForcedLeak Vulnerability Simulation
- **Location**: 
  - `ForcedLeakAgent.agent` - No HITL confirmation, external endpoint
  - `DataExporter.cls` - External call without URL validation
- **Description**: Indirect prompt injection via Description field
- **Expected Detection**: AGENTFORCE-2.1 (Prompt Injection), AGENTFORCE-2.2 (Trusted URL Bypass)

## Test Execution

### Local Testing
```bash
# Download SquireX
curl -L -o squirex https://github.com/samudralap/squirex-apex-forge/releases/latest/download/squirex-macos-arm64
chmod +x squirex

# Run scan
./squirex scan -d ./force-app

# Run with specific rules
./squirex scan -d ./force-app --rules AGENTFORCE-1.1,AGENTFORCE-1.3 --sarif results.sarif
```

### CI/CD Testing
GitHub Actions workflow (.github/workflows/squirex-scan.yml) will:
1. Download latest SquireX binary
2. Run community scan (JSON output)
3. If license key provided, run SARIF scan
4. Upload SARIF to GitHub Security
5. Display results summary

## Expected Results

SquireX should detect:
- ✓ 2x Template Context Poisoning violations
- ✓ 1x System Context Escalation  
- ✓ 2x Excessive Agency Prevention violations
- ✓ 3x Variable Injection vulnerabilities
- ✓ 1x SOQL Injection vulnerability
- ✓ 2x ForcedLeak-style vulnerabilities

## Success Criteria
1. SARIF report generated and uploaded to GitHub Security
2. All critical vulnerabilities detected
3. Clear, actionable security findings
4. No false positives on secure patterns
5. CI/CD pipeline integration functional