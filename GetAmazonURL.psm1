############################################################
# Reject Amazon URL noise
############################################################
function GetAmazonURL([switch]$Check, [switch]$VertionCheck){
	# バージョンチェックとオンライン更新
	if( $VertionCheck ){
		$ModuleName = "TestModule"
		$GitHubName = "MuraAtVwnet"

		$Module = $ModuleName + ".psm1"
		$Vertion = "Vertion" + $ModuleName + ".txt"
		$VertionTemp = "VertionTemp" + $ModuleName + ".tmp"

		$Update = $False

		if( -not (Test-Path ~/$Vertion)){
			$Update = $True
		}
		else{
			# 現在のバージョン
			$LocalVertion = Get-Content -Path ~/$Vertion

			# ローカルにリポジトリに置いてあるバージョン管理ファイルをダウンロードし読み込む
			Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/Vertion.txt -OutFile ~/$VertionTemp
			$NowVertion = Get-Content -Path ~/$VertionTemp
			Remove-Item ~/$VertionTemp

			# バージョン チェック
			if( $LocalVertion -ne $NowVertion ){
				$Update = $True
			}
		}

		if( $Update ){
			Write-Output "最新版に更新します"
			Write-Output "更新完了後、PowerShell プロンプトを開きなおしてください"
			Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/OnlineInstall.ps1 -OutFile ~/OnlineInstall.ps1
			& ~/OnlineInstall.ps1
			Write-Output "更新完了"
			Write-Output "PowerShell プロンプトを開きなおしてください"
		}
		else{
			Write-Output "更新の必要はありません"
		}
		return
	}

	############ 本来の処理

	$ChromePath = Join-Path $env:ProgramFiles "Google\Chrome\Application\chrome.exe"
	$SakuraURL = "https://sakura-checker.jp/search/"

	$FullURL = Get-Clipboard
	$FullURL = $FullURL -replace "\?tag.+", ""
	if(($FullURL -match "https://www\.amazon\.co\.jp") -or ($FullURL -match "https://www\.amazon\.com")){
		if( $FullURL.Contains("/product/") ){
			if(($FullURL -match "/product/(?<DPUrl>.+?)/") -or ($FullURL -match "/product/(?<DPUrl>.+?)$")){
				#NOP
			}
		}
		elseif( $FullURL.Contains("/dp/") ){
			if( ($FullURL -match "/dp/(?<DPUrl>.+?)/") -or ($FullURL -match "/dp/(?<DPUrl>.+?)$") ){
				#NOP
			}
		}
		else{
			echo "This is not a product page"
			return
		}


		$DP = $Matches.DPUrl
		if( ($DP -match "(?<DPUrl>.+?)\?ref") -or ($DP -match "(?<DPUrl>.+?)/ref") -or ($DP -match "(?<DPUrl>.+?)/pf_rd") -or ($DP -match "(?<DPUrl>.+?)\?pf_rd") ){
			$DP = $Matches.DPUrl
		}

		$DPUrl = "/dp/" + $DP

		if($FullURL -match "(?<AmazonUrl>https://.+?)/"){
			$AmazonUrl = $Matches.AmazonUrl
		}
		else{
			echo "Not URL"
			return
		}

		$GoodsUrl = $AmazonUrl + $DPUrl
		$GoodsUrl = $GoodsUrl -replace "\?.+$", ""

		echo $GoodsUrl
		$GoodsUrl | Set-Clipboard

		if($Check){
			if( Test-Path $ChromePath ){
				if( $GoodsUrl -match "\.com" ){
					echo "Sakura Checker is only supported by Amazon Japan"
				}
				else{
					$ProdactSearchURL = $SakuraURL + $DP + "/"
					. $ChromePath $ProdactSearchURL
				}
			}
			else{
				echo "Sakura Checker requires Google Chrome"
			}
		}
	}
	else{
		echo "Not an Amazon URL"
	}
}
