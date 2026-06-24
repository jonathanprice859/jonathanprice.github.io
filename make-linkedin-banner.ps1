Add-Type -AssemblyName System.Drawing

$width = 1584
$height = 396
$bmp = New-Object System.Drawing.Bitmap $width, $height
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$bg1 = [System.Drawing.Color]::FromArgb(255, 5, 11, 20)
$bg2 = [System.Drawing.Color]::FromArgb(255, 8, 18, 31)
$green = [System.Drawing.Color]::FromArgb(255, 52, 211, 153)
$cyan = [System.Drawing.Color]::FromArgb(255, 56, 189, 248)
$text = [System.Drawing.Color]::FromArgb(255, 238, 244, 252)
$muted = [System.Drawing.Color]::FromArgb(255, 158, 178, 200)
$lineCyan = [System.Drawing.Color]::FromArgb(40, 56, 189, 248)
$lineGreen = [System.Drawing.Color]::FromArgb(45, 52, 211, 153)

$rect = New-Object System.Drawing.Rectangle 0, 0, $width, $height
$brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, $bg1, $bg2, 35.0
$g.FillRectangle($brush, $rect)
$brush.Dispose()

function Draw-CircuitTile([System.Drawing.Graphics]$graphics, [int]$ox, [int]$oy) {
    $penCyan = New-Object System.Drawing.Pen $lineCyan, 1.0
    $penGreen = New-Object System.Drawing.Pen $lineGreen, 1.0
    $brushGreen = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(60, 52, 211, 153))
    $brushCyan = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(55, 56, 189, 248))

    $graphics.DrawLine($penCyan, $ox, $oy + 45, $ox + 55, $oy + 45)
    $graphics.DrawLine($penCyan, $ox + 75, $oy + 45, $ox + 120, $oy + 45)
    $graphics.DrawLine($penCyan, $ox, $oy + 90, $ox + 35, $oy + 90)
    $graphics.DrawLine($penCyan, $ox + 100, $oy + 90, $ox + 180, $oy + 90)
    $graphics.DrawLine($penCyan, $ox + 45, $oy, $ox + 45, $oy + 45)
    $graphics.DrawLine($penCyan, $ox + 90, $oy + 35, $ox + 90, $oy + 90)
    $graphics.DrawLine($penGreen, $ox + 55, $oy + 45, $ox + 75, $oy + 45)
    $graphics.DrawLine($penGreen, $ox + 55, $oy + 90, $ox + 100, $oy + 90)
    $graphics.FillEllipse($brushGreen, $ox + 42, $oy + 42, 6, 6)
    $graphics.FillEllipse($brushCyan, $ox + 87, $oy + 87, 5, 5)
    $graphics.DrawRectangle($penCyan, $ox + 72, $oy + 72, 36, 22)

    $penCyan.Dispose(); $penGreen.Dispose(); $brushGreen.Dispose(); $brushCyan.Dispose()
}

for ($x = 0; $x -lt $width; $x += 180) {
    for ($y = 0; $y -lt $height; $y += 180) {
        Draw-CircuitTile $g $x $y
    }
}

$glowBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(28, 52, 211, 153))
$g.FillEllipse($glowBrush, 1050, -60, 360, 360)
$glowBrush.Dispose()

$chipPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(80, 148, 163, 184)), 1.0
$g.DrawRectangle($chipPen, 500, 50, 90, 58)
$g.FillRectangle((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(90, 52, 211, 153))), 512, 64, 8, 8)
$g.FillRectangle((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(75, 56, 189, 248))), 540, 64, 8, 8)
$g.DrawLine($chipPen, 512, 88, 560, 88)
$chipPen.Dispose()

# Change this to swap the highlighted tag on the banner
$taglineAccent = "Endpoint Management"

$fontTitle = [System.Drawing.Font]::new("Segoe UI", 44.0, [System.Drawing.FontStyle]::Bold)
$fontSub = [System.Drawing.Font]::new("Segoe UI", 18.0, [System.Drawing.FontStyle]::Regular)
$fontSubAccent = [System.Drawing.Font]::new("Segoe UI", 18.0, [System.Drawing.FontStyle]::Bold)
$fontEyebrow = [System.Drawing.Font]::new("Consolas", 11.0, [System.Drawing.FontStyle]::Bold)

$sfRight = New-Object System.Drawing.StringFormat
$sfRight.Alignment = [System.Drawing.StringAlignment]::Far
$sfRight.LineAlignment = [System.Drawing.StringAlignment]::Near

$sfLeft = New-Object System.Drawing.StringFormat
$sfLeft.Alignment = [System.Drawing.StringAlignment]::Near
$sfLeft.LineAlignment = [System.Drawing.StringAlignment]::Near

$rightX = $width - 80
$subtitleY = $height - 50
$blockPadding = 22

$eyebrowText = "STATUS: ONLINE"
$eyebrowSize = $g.MeasureString($eyebrowText, $fontEyebrow)
$pillW = [int]$eyebrowSize.Width + 46
$pillH = 28
$pillX = $rightX - $pillW
$pillY = 86
$g.FillRectangle((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(40, 52, 211, 153))), $pillX, $pillY, $pillW, $pillH)
$g.DrawRectangle((New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(90, 52, 211, 153))), $pillX, $pillY, $pillW, $pillH)
$g.FillEllipse((New-Object System.Drawing.SolidBrush $green), $pillX + 12, $pillY + 10, 8, 8)
$g.DrawString($eyebrowText, $fontEyebrow, (New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 167, 243, 208))), ($pillX + 28), ($pillY + 7), $sfLeft)

$line1Text = "Access Granted."
$line2Text = "Coffee Required."
$line1H = $g.MeasureString($line1Text, $fontTitle).Height
$line2H = $g.MeasureString($line2Text, $fontTitle).Height
$headlineGap = 6
$headlineBlockH = $line1H + $headlineGap + $line2H
$zoneTop = $pillY + $pillH + $blockPadding
$zoneBottom = $subtitleY - $blockPadding
$headlineY = $zoneTop + (($zoneBottom - $zoneTop) - $headlineBlockH) / 2

$g.DrawString($line1Text, $fontTitle, (New-Object System.Drawing.SolidBrush $text), $rightX, $headlineY, $sfRight)
$g.DrawString($line2Text, $fontTitle, (New-Object System.Drawing.SolidBrush $green), $rightX, ($headlineY + $line1H + $headlineGap), $sfRight)

$subPrefix = "IAM  |  M365  |  Infrastructure  |  "
$prefixW = $g.MeasureString($subPrefix, $fontSub).Width
$suffixW = $g.MeasureString($taglineAccent, $fontSubAccent).Width
$subStartX = $rightX - ($prefixW + $suffixW)
$g.DrawString($subPrefix, $fontSub, (New-Object System.Drawing.SolidBrush $muted), $subStartX, $subtitleY, $sfLeft)
$g.DrawString($taglineAccent, $fontSubAccent, (New-Object System.Drawing.SolidBrush $green), ($subStartX + $prefixW), $subtitleY, $sfLeft)

$outPath = Join-Path $PSScriptRoot "linkedin-banner.png"
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)

$fontTitle.Dispose(); $fontSub.Dispose(); $fontSubAccent.Dispose(); $fontEyebrow.Dispose()
$g.Dispose(); $bmp.Dispose()

Write-Output "Saved: $outPath"