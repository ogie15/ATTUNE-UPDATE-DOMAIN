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
> > > @{'CSV'=$true;'NewDomain'="fabrikram.com";'CSVPath'="C:\Users\user\Desktop\ATTUNE";'CSVFileName'="UserEmail.csv"}
> > > ```
> > > 2. ###### **When a CSV File is not used** 
> > > ```powershell
> > > @{'CSV'=$false;'OldDomain'="contoso.com";'NewDomain'="fabrikram.com"}
> > > ```
> > **Below is a sample CSV**
> > | UserPrincipalName |
> > | :----: | 
> > | Test001@contoso.com |
> > | Test002@contoso.com |
> > | Test003@contoso.com |
> > | Test004@contoso.com |
> > | Test005@contoso.com |
> > ---
>
> #### *Below is a table explaining how to create the variables on Attune with matching data types:*
> ---
> | Vaule in script | Value Location in Attune | Parameter location in Attune| Data Type | Example |
> | :----: | :---: | :---: | :---: | :---: |
> | {username0365.value} | (value) Inputs->Text Vaules->Variable | (username0365) Inputs->Text Vaules->Name | String | globaladmin@contoso.onmicrosoft.com |
> | {password0365.value} | (value) Inputs->Text Vaules->Variable | (password0365) Inputs->Text Parameter->Name | String | Pas$W0rd | 
> | {hashconfig0365.value} | (value) Inputs->Text Vaules->Variable | (hashconfig0365) Inputs->Text Parameter->Name | Hash Table | @{'CSV'=$true;'NewDomain'="fabrikram.com";'CSVPath'="C:\Users\user\Desktop\ATTUNE\ATTUNE_PUSH_FILES";'CSVFileName'="Users.csv"} @{'CSV'=$false;'OldDomain'="contoso.com";'NewDomain'="fabrikram.com"} |
> ---
[![SERVERTRIBE](https://www.servertribe.com/wp-content/themes/mars/assets/images/attune_logo.svg)](https://www.servertribe.com/)
***&copy;2021 Powered by ServerTribe***
