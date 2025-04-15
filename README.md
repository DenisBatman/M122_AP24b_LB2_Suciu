
# Documentation – LB2: Configuration Data Outside the Script (PowerShell Part)

## Teamwork
This project was done in a team of 2 people. One of us worked on the Bash part (Linux), and I worked on the **PowerShell part for Windows**.

This documentation is for the PowerShell script.

## Goal
We should find ways to keep config values outside of the script. These values should be easy to change, for example: IP address, port or server name.

## Methods
I tested two ways to load config data in PowerShell:

1. **.psd1 file**  
   This is a PowerShell data file. It looks like a hashtable. It is good for structured config.

2. **JSON file**  
   This is a normal JSON file. PowerShell can read it with `Get-Content` and `ConvertFrom-Json`.

## Files

### config.psd1  
```powershell
@{
    ServerIP = '192.168.1.200'
    Port     = 443
    UseSSL   = $true
}
```

### config.json  
```json
{
    "ServerIP": "192.168.1.200",
    "Port": 443,
    "UseSSL": true
}
```

### Script (script.ps1) – Example part  
```powershell
# Load config from .psd1
$config = Import-PowerShellDataFile -Path "config.psd1"
Write-Host "Server IP from PSD1: $($config.ServerIP)"

# Load config from JSON
$json = Get-Content -Path "config.json" | ConvertFrom-Json
Write-Host "Server IP from JSON: $($json.ServerIP)"
```

## Comparison

| Thing           | .psd1 file                 | JSON file                 |
|----------------|----------------------------|---------------------------|
| Easy to use     | yes, for PowerShell        | yes                       |
| Tool needed     | no extra tool              | no, just built-in cmdlets |
| Format          | PowerShell style           | common and universal      |
| Best for        | PowerShell only projects   | cross-platform projects   |

## Example Output

```
Server IP from PSD1: 192.168.1.200
Server IP from JSON: 192.168.1.200
```

## What I learned
I learned how to load settings from external files in PowerShell. I now know how to use `.psd1` and `.json`.  
.psd1 is nice for PowerShell scripts. JSON is better if other systems also use the same config.  
It is better to keep the config in a file instead of writing it inside the script.
