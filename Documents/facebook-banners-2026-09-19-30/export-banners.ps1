param(
  [string]$SourceDirectory = $PSScriptRoot
)

Add-Type -AssemblyName System.Drawing

$taskInterpolation = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$taskSmoothing = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$taskPixelOffset = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$taskCompositing = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$taskPngCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
  Where-Object { $_.MimeType -eq 'image/png' } |
  Select-Object -First 1

function New-Canvas {
  param([int]$Width, [int]$Height)
  New-Object System.Drawing.Bitmap($Width, $Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
}

function Set-Quality {
  param([System.Drawing.Graphics]$Graphics)
  $Graphics.InterpolationMode = $taskInterpolation
  $Graphics.SmoothingMode = $taskSmoothing
  $Graphics.PixelOffsetMode = $taskPixelOffset
  $Graphics.CompositingQuality = $taskCompositing
}

Get-ChildItem -LiteralPath $SourceDirectory -Filter '*-source.png' | Sort-Object Name | ForEach-Object {
  $taskSource = [System.Drawing.Image]::FromFile($_.FullName)
  try {
    $taskBaseName = $_.BaseName -replace '-source$', ''

    $taskPortrait = New-Canvas -Width 1080 -Height 1350
    $taskPortraitGraphics = [System.Drawing.Graphics]::FromImage($taskPortrait)
    try {
      Set-Quality -Graphics $taskPortraitGraphics
      $taskPortraitGraphics.DrawImage($taskSource, 0, 0, 1080, 1350)
      $taskPortrait.Save((Join-Path $SourceDirectory ($taskBaseName + '-1080x1350.png')), $taskPngCodec, $null)
    }
    finally {
      $taskPortraitGraphics.Dispose()
      $taskPortrait.Dispose()
    }

    $taskSquare = New-Canvas -Width 1080 -Height 1080
    $taskSquareGraphics = [System.Drawing.Graphics]::FromImage($taskSquare)
    try {
      Set-Quality -Graphics $taskSquareGraphics

      $taskCropSize = [Math]::Min($taskSource.Width, $taskSource.Height)
      $taskCropX = [int](($taskSource.Width - $taskCropSize) / 2)
      $taskCropY = [int](($taskSource.Height - $taskCropSize) / 2)
      $taskDestination = New-Object System.Drawing.Rectangle(0, 0, 1080, 1080)
      $taskSourceRect = New-Object System.Drawing.Rectangle($taskCropX, $taskCropY, $taskCropSize, $taskCropSize)
      $taskSquareGraphics.DrawImage($taskSource, $taskDestination, $taskSourceRect, [System.Drawing.GraphicsUnit]::Pixel)

      $taskShade = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(165, 30, 0, 20))
      try { $taskSquareGraphics.FillRectangle($taskShade, 0, 0, 1080, 1080) }
      finally { $taskShade.Dispose() }

      $taskPanelWidth = [int][Math]::Round(1080 * $taskSource.Width / $taskSource.Height)
      $taskPanelX = [int][Math]::Round((1080 - $taskPanelWidth) / 2)
      $taskShadow = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 0, 0, 0))
      try { $taskSquareGraphics.FillRectangle($taskShadow, $taskPanelX - 10, 0, $taskPanelWidth + 20, 1080) }
      finally { $taskShadow.Dispose() }

      $taskSquareGraphics.DrawImage($taskSource, $taskPanelX, 0, $taskPanelWidth, 1080)
      $taskSquare.Save((Join-Path $SourceDirectory ($taskBaseName + '-1080x1080.png')), $taskPngCodec, $null)
    }
    finally {
      $taskSquareGraphics.Dispose()
      $taskSquare.Dispose()
    }
  }
  finally {
    $taskSource.Dispose()
  }
}
