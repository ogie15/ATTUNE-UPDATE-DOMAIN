# This step Installs the MSOnline Module

## Region for ExecutionPolicy

- *The script in this region first gets the execution policy of the current PowerShell session.*
- *Then checks if it is set to Unrestricted.*
- *`If` it is set, it does nothing but writes a message to the screen.*
- *`Else` will set the execution policy to Unrestricted for the current session.*

---

## Region to check if MSOnline Module is installed

- *First checks if the MSOnline module is installed*
- *`If` installed, it does nothing but writes a message to the screen.*
- *`Else` goes ahead to installs the module and writes a message to the screen.*
