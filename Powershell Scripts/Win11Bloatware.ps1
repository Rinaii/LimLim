# List of keywords to search for in app names
$AppsToRemove = @(
    "Microsoft.Copilot",
    "Microsoft.BingNews",
    "Microsoft.GamingApp",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.BingSearch",
    "Microsoft.BingWeather", 
    "DolbyLaboratories.DolbyAccess",
    "Microsoft.PowerAutomateDesktop",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.GetHelp",
    "Microsoft.ZuneMusic",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.Xbox.TCUI",
    "Microsoft.Windows.DevHome",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.WindowsAlarms",
    "Clipchamp.Clipchamp",
    "Microsoft.XboxGameCallableUI",
	"Microsoft.YourPhone",                            
    "MicrosoftCorporationII.QuickAssist"
)

foreach ($Keyword in $AppsToRemove) {
    # Remove for current user
    $UserPackages = Get-AppxPackage | Where-Object { $_.Name -like "*$Keyword*" }
    foreach ($Package in $UserPackages) {
        Write-Output "Removing app for current user: $($Package.Name)"
        Remove-AppxPackage -Package $Package.PackageFullName -ErrorAction SilentlyContinue
    }

    # Remove provisioned packages (for new users)
    $ProvisionedPackages = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like "*$Keyword*" }
    foreach ($ProvPackage in $ProvisionedPackages) {
        Write-Output "Removing provisioned app: $($ProvPackage.DisplayName)"
        Remove-AppxProvisionedPackage -Online -PackageName $ProvPackage.PackageName -ErrorAction SilentlyContinue
    }

    # Remove for all users (if already installed for others)
    $AllUserPackages = Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*$Keyword*" }
    foreach ($Package in $AllUserPackages) {
        Write-Output "Removing app for all users: $($Package.Name)"
        Remove-AppxPackage -Package $Package.PackageFullName -AllUsers -ErrorAction SilentlyContinue
    }
}

Write-Output "Bloatware removal complete for all users and future users."
