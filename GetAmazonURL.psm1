############################################################
# Reject Amazon URL noise
############################################################
function GetAmazonURL([switch]$Check){
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
