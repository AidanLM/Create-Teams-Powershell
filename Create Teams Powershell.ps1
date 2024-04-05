# Connect to Microsoft Teams
Connect-MicrosoftTeams

# Prompt user for team information
$teamName = Read-Host "Enter the team name"
$teamType = Read-Host "Enter the type of team"
$emailAddress = Read-Host "Enter the email address for the team"
$owner = Read-Host "Enter the owner of the team"
$teamMembers = (Read-Host "Enter team members (comma-separated)").Split(',')
$Visibility = Read-Host "Set visibility"


# Create a new team
New-Team -DisplayName $teamName -Description $teamType -MailNickName $emailAddress -Visibility $Visibility

Write-Host "Team '$teamName' created successfully!"

# Wait for some time before continuing
Start-Sleep -Seconds 15

# Add owner to the team
$teamprops = Get-Team -DisplayName $teamName
Add-TeamUser -GroupId $teamprops.GroupId -User $owner

# Add each member to the team
foreach ($user in $teamMembers) {
    Add-TeamUser -GroupId $teamprops.GroupId -User $user.Trim() # Trim to remove leading/trailing whitespace
    Write-Host "User '$user' added to the team."
}

Write-Host "Team $teamName is now completed!"