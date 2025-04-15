# Pfade zur Konfigurationsdatei
$jsonPath = Join-Path -Path $PSScriptRoot -ChildPath "config_json.json"
$psd1Path = Join-Path -Path $PSScriptRoot -ChildPath "config_psd1.psd1"
$config = $null

# Wenn JSON-Datei existiert, diese laden
if (Test-Path $jsonPath) {
    Write-Host "Lade Konfiguration aus JSON-Datei: $jsonPath"
    try {
        $jsonString = Get-Content -Path $jsonPath -Raw
        $config = $jsonString | ConvertFrom-Json
    }
    catch {
        Write-Host "Fehler beim Einlesen oder Verarbeiten der JSON-Datei." -ForegroundColor Red
        exit 1
    }
}
# Wenn PSD1-Datei existiert, diese laden
elseif (Test-Path $psd1Path) {
    Write-Host "Lade Konfiguration aus PSD1-Datei: $psd1Path"
    try {
        $config = Import-PowerShellDataFile -Path $psd1Path
    }
    catch {
        Write-Host "Fehler beim Einlesen der PSD1-Datei." -ForegroundColor Red
        exit 1
    }
}
# Wenn keine der beiden Dateien vorhanden ist
else {
    Write-Host "Keine Konfigurationsdatei gefunden (weder JSON noch PSD1)." -ForegroundColor Red
    exit 1
}

# Zugriff auf Konfigurationswerte
Write-Host "Verbindung zu Server: $($config.ServerIP):$($config.Port)"

if ($config.UseSSL) {
    Write-Host "SSL-Verbindung wird verwendet."
} else {
    Write-Host "Verbindung ohne SSL."
}
