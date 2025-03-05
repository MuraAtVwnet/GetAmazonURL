Amazon URL の必要部分のみにする

■ これは何?
Amazon の URL はノイズだらけなので、必要な部分だけを取り出します
amazon.co.jp と amazon.com に対応しています

Windows 上でしか動作確認していませんが、Mac Linux でも動くと思います


■ 使い方
Amazon URL をクリップボードにコピーして、PowerShell プロンプト で GetAmazonURL と入力してください
必要部分だけの URL がクリップボードにセットされます

-Check
サクラチェッカー(https://sakura-checker.jp)でのチェックを表示します(要 Google Chrome)

-VertionCheck
スクリプトが更新されていたらオンライン更新します


■ Online Install 方法
# 以下コマンドでインストール
$ModuleName = "GetAmazonURL"
$GitHubName = "MuraAtVwnet"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/OnlineInstall.ps1 -OutFile ~/OnlineInstall.ps1
& ~/OnlineInstall.ps1


■ Uninstall 方法
~/UnInstallGetAmazonURL.ps1 を実行して下さい
(問い合わせが来たら Enter)

■ 動作確認環境
PowerShell 5.1
PowerShell 7.x

■ Web サイト
PowerShell で Amazon URL を必要部分のみにする
http://www.vwnet.jp/windows/PowerShell/2022091801/GetAmazonURL.htm

■ リポジトリ
GitHub で公開しているので、最新版が欲しい方はこちらから Clone してください。

https://github.com/MuraAtVwnet/GetAmazonURL
git@github.com:MuraAtVwnet/GetAmazonURL.git


