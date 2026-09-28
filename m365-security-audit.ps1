Write-Host ""
Write-Host "================================"
Write-Host "    M365 SECURITY AUDIT TOOL"
Write-Host "================================"
Write-Host ""

# Load Microsoft 365 user data
$users = Get-Content "./mock_m365_users.json" | ConvertFrom-Json

# Stale account threshold
$staleThreshold = (Get-Date).AddDays(-90)

# Audit account information
$totalUsers = $users.Count

$disabledUsers = @(
    $users | Where-Object { $_.accountEnabled -eq $false }
)

$guestUsers = @(
    $users | Where-Object { $_.userType -eq "Guest" }
)

$adminUsers = @(
    $users | Where-Object { $_.isAdmin -eq $true }
)

$usersWithoutMFA = @(
    $users | Where-Object {
        $_.accountEnabled -eq $true -and
        $_.mfaRegistered -eq $false
    }
)

$staleUsers = @(
    $users | Where-Object {
        $_.accountEnabled -eq $true -and
        [datetime]$_.lastSignIn -lt $staleThreshold
    }
)

# Summary
Write-Host "Microsoft 365 Account Summary"
Write-Host "-----------------------------"
Write-Host "Total Accounts:       $totalUsers"
Write-Host "Disabled Accounts:    $($disabledUsers.Count)"
Write-Host "Guest Accounts:       $($guestUsers.Count)"
Write-Host "Admin Accounts:       $($adminUsers.Count)"
Write-Host "Accounts Without MFA: $($usersWithoutMFA.Count)"
Write-Host "Stale Accounts:       $($staleUsers.Count)"
Write-Host ""

# Security findings
Write-Host "SECURITY FINDINGS"
Write-Host "-----------------------------"

foreach ($user in $usersWithoutMFA) {
    Write-Host "HIGH    $($user.displayName) - MFA not registered"
}

foreach ($user in $staleUsers) {
    Write-Host "HIGH    $($user.displayName) - No sign-in for over 90 days"
}

foreach ($user in $disabledUsers) {
    Write-Host "MEDIUM  $($user.displayName) - Account is disabled"
}

foreach ($user in $guestUsers) {
    Write-Host "REVIEW  $($user.displayName) - External guest account"
}

foreach ($user in $adminUsers) {
    Write-Host "REVIEW  $($user.displayName) - Privileged administrator account"
}

Write-Host ""
Write-Host "================================"
Write-Host "       AUDIT COMPLETE"
Write-Host "================================"
Write-Host ""