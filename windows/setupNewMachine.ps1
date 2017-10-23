Set-ExecutionPolicy Unrestricted

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

choco install git -y
choco install 7zip -y
choco install vim -y
refreshenv

Write-Host "Downloading vim-plug"
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\vimfiles\autoload\plug.vim"
  )
)

git clone https://github.com/ghost7/configs $env:TEMP\configs
cp $env:TEMP\configs\windows\_vimrc ~\

vim +PlugInstall +qall
