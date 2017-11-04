
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

$programs = @(
	"git",
	"7zip",
	"vim",
	"rust",
	"putty",
	"notepadplusplus"
	"visualstudiocode"
	"vlc"
	"googlechrome"
)

foreach($program in $programs) {
	Invoke-Expression "choco install $program -y"
}
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

$tempConfigPath = "$env:TEMP\configs"
if(Test-Path $tempConfigPath) {
    Remove-Item $tempConfigPath -Recurse -Force
}

git clone https://github.com/ghost7/configs $tempConfigPath
cp $tempConfigPath\windows\_vimrc ~\

vim +PlugInstall +qall

