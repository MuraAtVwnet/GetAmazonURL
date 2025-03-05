# モジュール名
$ModuleName = "GetAmazonURL"

# モジュール Path
$ModulePath = Join-Path (Split-Path $PROFILE -Parent) "Modules"

# モジュールが配置されている Path
$RemovePath = Join-Path $ModulePath $ModuleName

# ディレクトリ削除
if( Test-Path $RemovePath ){
	Remove-Item $RemovePath -Force -Recurse
}

# オンラインインインストール対応
$UnInstaller = "UnInstall" + $ModuleName + ".ps1"
if( Test-Path ~/$UnInstaller ){
	Remove-Item ~/$UnInstaller
}

# バージョン管理ファイル削除
$Vertion = "Vertion" + $ModuleName + ".txt"
if( Test-Path ~/$Vertion ){
	Remove-Item ~/$Vertion
}


