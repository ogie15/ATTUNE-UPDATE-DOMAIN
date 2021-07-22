
<!-- @{'CSV'=$false;'OldDomain'="olddomain.com";'NewDomain'="newdomain.com";'CSVPath'="C:\Users\user\Desktop\ATTUNE\ATTUNE_PUSH_FILES";'CSVFileName'="Users.csv"} -->

@{'CSV'=$true;'NewDomain'="newdomain.com";'CSVPath'="C:\Users\user\Desktop\ATTUNE\ATTUNE_PUSH_FILES";'CSVFileName'="Users.csv"}

@{'CSV'=$false;'OldDomain'="jago.ga";'NewDomain'="blokeessentials.tk"}

blokeessentials.tk


## **Update-Domain**
> #### **Region for ExecutionPolicy**
> - *The script above first gets the execution policy of the current PowerShell session.*
> 
> - *Then checks if it is set to Unrestricted.*
> 
> - *`If` it is set, then skips and echos a message to the screen.*
>
> - *`Else` it sets the execution policy to Unrestricted.*
> ---
> #### **Region for ConnectTo0365**
> 
> - *First the MSOnline Module is imported to the current session.*
> - *Then the values below are set:*
>
> | Variable Name | Description | Value |
> | :----: | :----: | :---: |
> | UserName  | This is the Global Admin Sign-in Userprincipalname | {username0365.value} |
> | PasswordPassword | This is the Global Admin Password | {password0365.value} |
> ---
> #### **Region for HashTable Configuration**
>
> - *Next will be to set the values of the HashTable Configuration.*
>
> | Variable Name | Description | Value |
> | :----: | :----: | :---: |
> | HashConfig | This holds a hash table containing the configuration needed for the script to update the desired users' domain | {hashconfig0365.value} |
> > ---
> > ##### **The HashTable Configuration contains the below:**
> >  1. CSV - (`DataType - Boolen`) - This tells the script if a CSV file is been used or not.
> >  2. OldDomain - (`DataType - <String>`) - Holds the value of the Old Domain.
> >  3. NewDomain - (`DataType - <String>`) - Holds the value of the New Domain.
> >  4. CSVPath - (`DataType - <String>`) - Holds the name of the Path/Location of the CSV file on the Attune Node.
> >  5. CSVFileName - (`DataType <String>`) -  Holds the name of the CSV file that will be used
> > ##### **Hash Table Configuration Syntax:**
> > > 1. ###### **When a CSV File is used** 
> > > ```powershell
> > > @{'CSV'=$true;'NewDomain'="newdomain.com";'CSVPath'="C:\Users\user\Desktop\ATTUNE";'CSVFileName'="UserEmail.csv"}
> > > ```
> > > 2. ###### **When a CSV File is not used** 
> > > ```powershell
> > > @{'CSV'=$false;'OldDomain'="olddomain.com";'NewDomain'="newdomain.com"}
> > > ```
> > **Below is a sample CSV**
> > | UserPrincipalName |
> > | :----: | 
> > | Audit.Test@blokeessentials.tk |
> > | SharedTest@blokeessentials.tk |
> > | SharedTest@blokeessentials.tk |
> > | SharedTest@blokeessentials.tk |
> > | SharedTest@blokeessentials.tk |
> > ---
>
> #### *Below is a table explaining how to create the variables on Attune with matching data types:*
> ---
> | Vaule in script | Value Location in Attune | Parameter location in Attune| Data Type | Example |
> | :----: | :---: | :---: | :---: | :---: |
> | {accesskey.value} | (value) Inputs->Text Vaules->Variable | (access) Inputs->Text Vaules->Name | String | HKOPUHIVJOQQN3YNLCIL |
> | {secretkey.value} | (value) Inputs->Text Vaules->Variable | (secretkey) Inputs->Text Parameter->Name | String | MJYj7oBcNMTe+R+TTIWdQqXLYcttQ8IOwh1O9zH5 | 
> | {hashvalue.value} | (value) Inputs->Text Vaules->Variable | (hashvalue) Inputs->Text Parameter->Name | Hash Table | @{"i-0ffhdd7a07b129f59"="eu-west-2";"i-01109b6fb6b9d30fe"="eu-west-1"} |
> ---
>---
