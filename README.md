# Microsoft 365 Security Audit Tool

A PowerShell security auditing tool for Microsoft 365 identity and account security.

The project demonstrates how Microsoft 365 user information can be analysed to identify common identity and access security risks such as missing MFA, stale accounts, guest users, disabled accounts and privileged administrators.

## 🎯 What This Tool Audits

The current version checks for:

* Total Microsoft 365 accounts
* Disabled accounts
* External guest accounts
* Privileged administrator accounts
* Active accounts without MFA
* Active accounts with no sign-in for more than 90 days
* Security findings categorised as HIGH, MEDIUM or REVIEW

## 🛠️ Technologies

* PowerShell 7
* Microsoft 365
* Microsoft Graph PowerShell SDK
* Identity and Access Management (IAM)
* Security auditing
* Git / GitHub

## 📁 Project Structure

```text
m365-security-audit-tool/
│
├── m365-security-audit.ps1
├── mock_m365_users.json
├── .gitignore
└── README.md
```

### `m365-security-audit.ps1`

The main PowerShell audit script.

It loads Microsoft 365-style user data, analyses account security properties and generates security findings.

### `mock_m365_users.json`

Contains mock Microsoft 365 user information used to develop and test the audit logic without requiring access to a production Microsoft 365 tenant.

### `.gitignore`

Prevents logs, reports, exports and potential credential files from accidentally being committed to GitHub.

## ⚙️ PowerShell Installation

The project was developed using PowerShell 7 on macOS.

PowerShell can be installed using Homebrew.

```bash
brew install --cask powershell
```

Verify the installation:

```bash
pwsh --version
```

Start PowerShell:

```bash
pwsh
```

## 🔗 Microsoft Graph PowerShell

The Microsoft Graph PowerShell SDK can be installed with:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

Microsoft Graph provides the API and PowerShell tooling that can be used to retrieve Microsoft 365 identity information from an authorised tenant.

The current project uses mock Graph-style data so the audit logic can be developed and tested safely without requiring a live Microsoft 365 environment.

## 🧪 Running the Audit

From the project directory:

```bash
pwsh ./m365-security-audit.ps1
```

Example output:

```text
================================
    M365 SECURITY AUDIT TOOL
================================

Microsoft 365 Account Summary
-----------------------------
Total Accounts:       5
Disabled Accounts:    1
Guest Accounts:       1
Admin Accounts:       1
Accounts Without MFA: 2
Stale Accounts:       1

SECURITY FINDINGS
-----------------------------
HIGH    Vegeta Prince - MFA not registered
HIGH    Levi Ackerman - MFA not registered
HIGH    Levi Ackerman - No sign-in for over 90 days
MEDIUM  Itachi Uchiha - Account is disabled
REVIEW  Levi Ackerman - External guest account
REVIEW  Satoru Gojo - Privileged administrator account

================================
       AUDIT COMPLETE
================================
```

## 🔍 Security Checks

### MFA Registration

Active accounts without MFA registration are identified for investigation.

```text
HIGH - MFA not registered
```

MFA is particularly important for protecting Microsoft 365 identities against compromised credentials.

### Stale Accounts

The tool identifies active accounts where the recorded last sign-in occurred more than 90 days ago.

```text
HIGH - No sign-in for over 90 days
```

Long-unused accounts should be reviewed to determine whether access is still required.

### Guest Accounts

External guest accounts are highlighted for review.

```text
REVIEW - External guest account
```

Guest access should be periodically reviewed to ensure external users still require access.

### Administrator Accounts

Privileged administrator accounts are identified for review.

```text
REVIEW - Privileged administrator account
```

This helps provide visibility into accounts with elevated access.

### Disabled Accounts

Disabled accounts are also included in the audit.

```text
MEDIUM - Account is disabled
```

These can be reviewed as part of account lifecycle and offboarding processes.

## 🌐 Live Microsoft 365 Integration

The project is structured so the mock data source can later be replaced with Microsoft Graph queries against an authorised Microsoft 365 environment.

For example, Microsoft Graph PowerShell can retrieve users with commands such as:

```powershell
Connect-MgGraph -Scopes "User.Read.All"

Get-MgUser -All
```

Additional Graph permissions and queries would be required for security registration, sign-in activity, directory roles and other security information.

The exact permissions should be limited to those required by the audit.

## 🔒 Security

No real Microsoft 365 credentials or production user information are stored in this repository.

The `.gitignore` file excludes common credential and generated-report files:

```text
.env
secrets.json
credentials.json
reports/
*.csv
*.log
```

Real credentials should never be hardcoded into PowerShell scripts or committed to source control.

## 🚧 Future Improvements

The project could be expanded to include:

* Live Microsoft Graph integration
* Conditional Access auditing
* Administrative role analysis
* Risky sign-in detection
* Authentication method analysis
* Licence reporting
* Mailbox forwarding checks
* Automated CSV/HTML security reports
* Security scoring
* Scheduled audits
* Microsoft Graph application authentication

## 🎯 Purpose

This project demonstrates practical PowerShell automation, Microsoft 365 administration, identity security and security auditing concepts.

It provides a foundation for automating common Microsoft 365 security reviews while keeping the development environment separate from production systems.
