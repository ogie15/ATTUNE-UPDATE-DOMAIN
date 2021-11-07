#Region for ExecutionPolicy
# Get Execution Policy of the current process
$Script:ProcessEP = Get-ExecutionPolicy -Scope Process

#Get the value of the Execution Policy and save it in the Variable
$Script:ValueProcessEP = ($Script:ProcessEP).value__

# Check if the Execution Policy of the process is set to Unrestricted
if ($Script:ValueProcessEP -eq 0) {

    # Write the message
    Write-Output "Execution Policy is already set to Unrestricted for the Process"
    # Check if the Execution Policy of the process is already set
}else{

    # Set the ExecutionPolicy of the Process to Unrestricted
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false

    # Checks if the Execution Policy has been set
    if ((Get-ExecutionPolicy -Scope Process).value__ -eq 0) {

        # Write the message
        Write-Output "Execution Policy is now set to Unrestricted for the Process"
    }
}
#EndRegion for ExecutionPolicy 


#Region to Check if MSOnline Module is installed 
#Region if module is installed, update module if version is not up to Version "1.1.183.57"
if($null -ne (Get-InstalledModule -Name MSOnline -RequiredVersion "1.1.183.57" -ErrorVariable +Error365V -ErrorAction SilentlyContinue)) {

    # Get the MSOnline module installed and save it in a variable
    $Script:GetMSOnline = Get-InstalledModule -Name MSOnline -RequiredVersion "1.1.183.57" -ErrorVariable +Error365V -ErrorAction SilentlyContinue

    # echo the message
    Write-Output "MSOnline PowerShell Module exists ... checking ..."

    # Gets the build number for the MSOnline Module 
    $Script:MSOnlineBuild = ($Script:GetMSOnline).Version

    # Checks the build number to meet requirements 
    if($Script:MSOnlineBuild -like "*1.1.183.57*") {

        # Saves and converts Module version name to a variable
        $Script:OutVersion = ((($Script:GetMSOnline).Version)).tostring()

        # echo the message
        Write-Output "MSOnline Module Version $Script:OutVersion meets the minimum requirement."

    # Check if the build version is on 13
    }else{
        
        # echo the message
        Write-Output "MSOnline PowerShell Module is updated :)"
    }
#EndRegion if the module is installed, update module if the version is not up to Version "1.1.183.57"
#Region If the module is not installed, install it 
}else{

    # echo the message
    Write-Output "MSOnline PowerShell Module is not installed"
    
    # echo the message
    Write-Output "MSOnline PowerShell Module is installing..."

    # Install MSOnline Powershell Module 
    Install-Module -Name MSOnline -RequiredVersion "1.1.183.57" -Scope "CurrentUser" -AllowClobber:$true -Confirm:$false -Force

    # echo the message
    Write-Output "MSOnline PowerShell Module is installed :)"
}
#EndRegion If the module is not installed, install it
#EndRegion Check if MSOnline Module is installed
