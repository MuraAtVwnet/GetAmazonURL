# Online installer
# リポジトリ名とモジュール名は同一名にしている前提
# インストーラーは install.ps1 にしている前提
# アンインストーラーは uninstall.ps1 にしている前提
# バージョン管理ファイルは vertion.txt にしている前提

$ModuleName = "GetAmazonURL"
$GitHubName = "MuraAtVwnet"

$Module = $ModuleName + ".psm1"
$Installer = "Install" + $ModuleName + ".ps1"
$UnInstaller = "UnInstall" + $ModuleName + ".ps1"
$Vertion = "Vertion" + $ModuleName + ".txt"

# ダウンロード
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/$Module -OutFile ~/$Module
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/install.ps1 -OutFile ~/$Installer
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/uninstall.ps1 -OutFile ~/$UnInstaller
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/Vertion.txt -OutFile ~/$Vertion

# インストーラー実行
& ~/$Installer

# 不要ファイル削除
Remove-Item ~/$Module
Remove-Item ~/$Installer

# オンラインインストーラー削除
Remove-Item ~/OnlineInstall.ps1


