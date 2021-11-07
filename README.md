# Using Attune to update Office 365 Users' Domain/UserPrincipalName

This Blueprint is used for updating users' Domain/UserPrincipalName on an Office 365 Tenant.

A Tenant is an Organization, an Office 365 Tenant is an instance of Office 365 for an organization.

## Pre-Blueprint Attune setup

1. On the Inputs tab, create a Windows Node for the host you wish to run this Blueprint.
1. On the Inputs tab, create a Windows Credentials to connect to the host you wish to run this Blueprint.
1. On the Inputs tab, create a Text value to store the values below:
    - 0365UserName: This is the Username of the Global Administrator (DataType: String).
    - 0365Password: This is the Password of the Global Administrator (DataType: String).
    - 036Hashconfig: This holds an array of configurations (DataType: HashTable).

---

Two configurations can be used for this Blueprint:

1. One with a CSV file holding specific users' that require an update and their new domain value.
1. One without a CSV file, but the name of the old domain and new domain.
    - *Note this update will affect all users on the tenant having the old domain specified*

*Below is a sample CSV:*

| UserPrincipalName |
| :----: |
| User001@contoso.com |
| User002@contoso.com |
| User003@contoso.com |
| User004@contoso.com |
| User005@contoso.com |

---

*Hash Table Configuration Syntax:*

```powershell

When a CSV File is used
@{'CSV'=$true;'NewDomain'="fabrikram.com";'CSVPath'="C:\Users\user\Desktop\ATTUNE";'CSVFileName'="UserEmail.csv"}

When a CSV File is not used
@{'CSV'=$false;'OldDomain'="contoso.com";'NewDomain'="fabrikram.com"}

```

Parameters & Descriptions

- CSV: Specifies if a CSV is used in the configuration Accepts only $true or $false.

- NewDomain: Holds the name of the users' new domain.

- OldDomain: Holds the name of the users' old domain.

- CSVPath: Holds the value of the CSV file path on the Attune Node.

- CSVFileName: Holds the value of the CSV file name.

---

## Blueprint Steps

1. Check and Install the MSOnline Module
1. Update the Office 365 Users' Domain
