#Region for ExecutionPolicy
# Get Execution Policy of the current process
$Script:ProcessEP = Get-ExecutionPolicy -Scope Process

#Get the value of the Execution Policy and save it in the Variable
$Script:ValueProcessEP = ($Script:ProcessEP).value__

# Check if the Execution Policy of the process is set to Unrestricted
if ($Script:ValueProcessEP -eq 0) {

    # echo the message
    Write-Output "Execution Policy is already set to Unrestricted for the Process"
# Check if the Execution Policy of the process is already set
}else{

    # Set the ExecutionPolicy of the Process to Unrestricted
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false

    # Checks if the Execution Policy has been set
    if ((Get-ExecutionPolicy -Scope Process).value__ -eq 0) {

        # echo the message
        Write-Output "Execution Policy is now set to Unrestricted for the Process"
    }
}
#EndRegion for ExecutionPolicy 



#Region ConnectTo0365
# Import Module for MSOnline
Import-Module -Name MSOnline

# Set the Global Admin Sign-in Userprincipalname
$Script:UserName = "{0365username.value}"

# Set the Global Admin Password
$Script:Password = "{0365password.value}"


#Region HashTable Configuration
$Script:HashConfig = {0365hashconfig.value}
#EndRegion HashTable Configuration


# Convert the password to secure string
$PasswordToSecureString = ConvertTo-SecureString $Password -AsPlainText -Force

# Saves UserName and Password for automation in the variable
$UserCredential = New-Object System.Management.Automation.PSCredential ($UserName, $PasswordToSecureString)

# Connects to the Office 365 (Azure Active Directory)
Connect-MsolService -Credential $UserCredential
#EndRegion ConnectTo0365


#Region Update-Domain Function
function Update-Domain {
    # Set the Cmdlet binding properties 
    [CmdletBinding(PositionalBinding = $false, SupportsShouldProcess = $false, ConfirmImpact = 'None')]
    param (
        # Set the Domain parameter
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $false,
            Position = 0,
            HelpMessage = "Enter a Verified Domain name on your Office 365 Tenant")]
        [Alias("Dn")]
        [String]
        $Domain,

        # Set the UserPrincipalName parameter
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [String]
        $UserPrincipalName,
        
        # Set the Force Parameter (switch)
        [Switch]$Force

    )  
    begin {
        # Set the divisor for the write-progress cmdlet
        [Int32]$Script:Divisor = 0

        # Set the incremental variable 
        [Int32]$Script:i = 0 
    }
    # process {
        
    # }
    end {

        # Creates a loop through all the input(UserPrincipalName) passed into the CMDLET
        foreach ($UserPrincipalNames in $input) {
            
            # If force switch is used
            if ($Force) { 

                #Region Get Prefix
                $Script:Symbol = $UserPrincipalNames.UserPrincipalName.IndexOf("@")

                $Script:Prefix = $UserPrincipalNames.UserPrincipalName.Substring(0, $Script:Symbol)

                $Script:NewUpn = ($Script:Prefix + "@" + $Domain)
                #EndRegion Get Prefix

                # Set write-progress incremental variable
                [Int32]$Script:i = [Int32]$Script:i + 1

                # Pause the scripts for 1 millisecond
                Start-Sleep -m 1

                try {
                    #Region Set New UserName
                    Set-MsolUserPrincipalName -UserPrincipalName $UserPrincipalNames.UserPrincipalName -NewUserPrincipalName $Script:NewUpn
                    #EndRegion Set New UserName

                    # Set the variable to the OldUpn of the User 
                    $Script:OldUpn = (($UserPrincipalNames).UserPrincipalName).tostring()

                    # Write out a message to screen regarding the change that has occurred
                    Write-Output `n "$Script:OldUpn has been changed to $Script:NewUpn"
                }
                catch {
                    # Echo out an error message
                    Write-Error ";( Error is above"
                    break #break the code
                }
            # IF Force Switch is not used 
            }else{
                # Write out the error message
                Write-Output "Force switch was not used"
            }
        }
    }
}
#EndRegion Update-Domain Function



#Region for setting update for Domain after checking if it is through a CSV File or not
function Set-Update{

    # To know what pattern of cmdlet to run if CSV is used 
    if ($Script:HashConfig['CSV'] -eq $true) {

        # Set the value of full path 
        $Script:FinalPath = $Script:HashConfig['CSVPath'] + "\" + $Script:HashConfig['CSVFileName']
    
        # Use CSV file to change the users in the domain
        Import-Csv -Path $Script:FinalPath | Update-Domain -Domain $Script:HashConfig['NewDomain'] -Force
    
    # To know what pattern of cmdlet to run if CSV is not used
    }elseif ($Script:HashConfig['CSV'] -eq $false) {

        # Save the domain with special test character to run a check
        $Script:ModOldDomain = "*@" + $Script:HashConfig['OldDomain'] + "*"

        # Check users' Domain for specified users
        Get-MsolUser | Where-Object { $_.UserPrincipalName -like $Script:ModOldDomain } | Update-Domain -Domain $Script:HashConfig['NewDomain'] -Force

    }
}
#EndRegion for setting update for Domain after checking if it is through a CSV File or not



#Region This function checks if the path is correct, if correct it runs the Set-Update function
function Get-PathandFile {

    # Save the value of the Csv path that is set in the configuration hashtable to the variable
    $Script:CSVPath = $Script:HashConfig['CSVPath']

    # Test Path & File segment (Path) (if it does not exist)
    if (!(Test-Path -Path $Script:HashConfig['CSVPath'])) {

        # Write out an error message if the path does not exist
        Write-Output "The File path $Script:CSVPath does not exist"

    # if it exists perform the below operation
    }else {
        
        # Write out a message if the file path exists
        Write-Output "The File path $Script:CSVPath exist..."

        # Save the value of the Csv filename that is set in the configuration hashtable to the variable
        $Script:CSVFileName = $Script:HashConfig['CSVFileName']

        # Get the particular file (if it does not exist)
        if (!(Get-ChildItem -Path $Script:HashConfig['CSVPath'] | Where-Object { $_.Name -like $Script:HashConfig['CSVFileName'] })) {
        
            # Writes out the message to the screen
            Write-Output "The File $Script:CSVFileName does not exist"
        
        # If the file exist 
        }else {

            # Writes out the message to the screen
            Write-Output $"The File $Script:CSVFileName exist"

            # Run the function Set-Update
            Set-Update

        }
    }
}
#EndRegion This function checks if the path is correct, if correct it runs the Set-Update function


#Region Check the configuration hashtable
# check the value of the CSV value if $True or $False entered
if ($Script:HashConfig['CSV'] -eq $true) {
    
    # Check the other parameters on the configuration file
    if ($Script:HashConfig['NewDomain'] -eq "" -or $null -eq $Script:HashConfig['NewDomain']`
    -or $Script:HashConfig['CSVPath'] -eq "" -or $Script:HashConfig['CSVFileName'] -eq ""`
    -or $null -eq $Script:HashConfig['CSVPath'] -or $null -eq $Script:HashConfig['CSVFileName']) {
        
        # Write out an error message
        Write-Output "Please check the configuration file"
    }else{
        
        # Run PathandFile Checker function 
        Get-PathandFile
    }
}elseif ($Script:HashConfig['CSV'] -eq $false) {

    if ($Script:HashConfig['OldDomain'] -eq "" -or $Script:HashConfig['NewDomain'] -eq ""`
    -or $null -eq $Script:HashConfig['OldDomain'] -or $null -eq $Script:HashConfig['NewDomain']) {
        
        # Write out an error message
        Write-Output "Please check the configuration file"
    }else {
        
        # Run the function Set-Update
        Set-Update
    }
}else {
    # Write out an error message
    Write-Output "Please check the data type of the value entered in the 'CSV' key in the HashTable Configuration 'ONLY datatype boolean Accepted!!'"
}   
#EndRegion Check the configuration hashtable
