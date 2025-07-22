#Description
#Checks if the PSWindowsUpdate module is installed and installs it if it is not already, then runs the install for all Microsoft Updates
# article related https://hamsammich00.github.io/posts/Please-Update-Your-Stuff/

#Check if the module is installed, then continue with the updates
$ModuleName = "PSWindowsUpdate"
if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
    Install-Module $ModuleName -Scope AllUsers -Force
}

#The actual updates
Get-WindowsUpdate -MicrosoftUpdate -Install 
#Add the commented line below after -install to just auto accept all
# -AcceptAll

#Add the commented line below after -isntall to cause an automatic reboot after installation
# -AutoReboot
