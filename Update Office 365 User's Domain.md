# This step updates the domain of the office 365 users' primary email adddress/sign-in address

The Blueprint first gets the Execution Policy of the current PowerShell session.

Then, check if the Execution Policy is set to Unrestricted.

If it's not, it then sets the Execution Policy to Unrestricted for the current PowerShell session.

Next, the MsOnline module is imported to the current session.

Then the values below are set:

1. UserName: This is the Global Administrator Sign-in Userprincipalname corresponding to the `0365UserName` set in the Inputs Tab.
1. Password: This is the Global Administrator Password corresponding to the `0365Password` set in the Inputs Tab.
1. HashConfig: This holds a hash table containing the configurations needed to to update the desired users' domain corresponding to the `0365Hashconfig` set in the Inputs Tab.

Next, a connection to Office 365 is made.

Then it checks the hash table configuration to know what configuration to update the Office 365 users' domain.
