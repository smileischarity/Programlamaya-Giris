param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$ImagePath,

    [switch]$CreateBackup
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Info {
    param([string]$Message)
    Write-Host "[+]" $Message
}

try {
    $resolvedPath = (Resolve-Path -LiteralPath $ImagePath).ProviderPath
    if (-not (Test-Path -LiteralPath $resolvedPath -PathType Leaf)) {
        throw "Belirtilen dosya bulunamadı: $ImagePath"
    }

    $extension = [System.IO.Path]::GetExtension($resolvedPath)
    if ($extension -ne ".bmp") {
        throw "Dosya uzantısı .bmp değil: $resolvedPath"
    }

    Add-Type -AssemblyName System.Drawing

    $originalBitmap = New-Object System.Drawing.Bitmap($resolvedPath)
    $newWidth = $originalBitmap.Width + 1
    $newHeight = $originalBitmap.Height

    if ($newWidth -lt 2 -or $newHeight -lt 1) {
        throw "Geçersiz BMP boyutu."
    }

    $newBitmap = New-Object System.Drawing.Bitmap($newWidth, $newHeight, $originalBitmap.PixelFormat)

    for ($y = 0; $y -lt $newHeight; $y++) {
        for ($x = 0; $x -lt $originalBitmap.Width; $x++) {
            $color = $originalBitmap.GetPixel($x, $y)
            $newBitmap.SetPixel($x, $y, $color)
        }

        $blue = [System.Drawing.Color]::FromArgb(0, 0, 255)
        $newBitmap.SetPixel($newWidth - 1, $y, $blue)
    }

    $dir = Split-Path -LiteralPath $resolvedPath -Parent
    $tempFile = Join-Path $dir ("{0}.tmp_{1}.bmp" -f [System.IO.Path]::GetFileNameWithoutExtension($resolvedPath), [guid]::NewGuid().ToString("N"))

    try {
        $newBitmap.Save($tempFile, $originalBitmap.RawFormat)
    }
    finally {
        $originalBitmap.Dispose()
        $newBitmap.Dispose()
    }

    if ($CreateBackup) {
        $backupPath = "{0}.bak_{1:yyyyMMddHHmmss}.bmp" -f $resolvedPath, (Get-Date)
        Copy-Item -LiteralPath $resolvedPath -Destination $backupPath -Force
        Write-Info "Yedek alındı: $backupPath"
    }

    Move-Item -LiteralPath $tempFile -Destination $resolvedPath -Force
    Write-Info "1 piksel genişlik eklendi: $resolvedPath"
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
