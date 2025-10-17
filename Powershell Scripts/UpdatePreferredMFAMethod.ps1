# Connect to Microsoft Graph with necessary permissions
Connect-MgGraph -Scopes "UserAuthenticationMethod.ReadWrite.All", "User.Read.All" -NoWelcome

# Specify the user for whom you want to update the preferred method
$userId = "arichmond@momotecho.com"

# Set the desired value for the preferred method
$preferredMethod = "push"

# Retrieve current sign-in preferences for the user
$currentPreference = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/users/$userId/authentication/signInPreferences"

# Check if the user already has the preferred method set
if ($currentPreference.userPreferredMethodForSecondaryAuthentication -eq $preferredMethod) {
    Write-Host "Default MFA method $preferredMethod is already set for $userId" -ForegroundColor Cyan
}
else {
    try {
        # Update the user's preferred method
        $body = @{
            userPreferredMethodForSecondaryAuthentication = $preferredMethod
        }
        Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/beta/users/$userId/authentication/signInPreferences" -Body $body -ContentType "application/json"
        Write-Host "Default MFA method updated to $preferredMethod for $userId successfully." -ForegroundColor Green
    }
    catch {
        # The registered method is not found for the user
        Write-Host "Default MFA method $preferredMethod is not registered by $userId" -ForegroundColor Yellow
    }
}