############################################################
# Reject Amazon URL noise
############################################################
function GetAmazonURL([switch]$Check){
	$ChromePath = Join-Path $env:ProgramFiles "Google\Chrome\Application\chrome.exe"
	$SakuraURL = "https://sakura-checker.jp/search/"

	$FullURL = Get-Clipboard
	if( ($FullURL -match "(?<GoodsUrl>https://www`.amazon`.co`.jp/dp/.+/?)") -or ($FullURL -match "(?<GoodsUrl>https://www`.amazon`.com/dp/.+/?)")){
		$GoodsUrl =  $Matches.GoodsUrl
		$dummy = $FullURL -match "/dp/(?<DPUrl>.+?)$"
		$DP = $Matches.DPUrl
	}
	else{
		if( $FullURL.Contains("/product/") ){
			$dummy = $FullURL -match "/product/(?<DPUrl>.+?)/"
			if($dummy -eq $false ){
				$dummy = $FullURL -match "/product/(?<DPUrl>.+?)$"
			}
		}
		else{
			$dummy = $FullURL -match "/dp/(?<DPUrl>.+?)/"
			if($dummy -eq $false ){
				$dummy = $FullURL -match "/dp/(?<DPUrl>.+?)$"
			}
		}

		$DP = $Matches.DPUrl
		$DPUrl = "/dp/" + $DP

		$dummy = $FullURL -match "(?<AmazonUrl>https://.+?)/"
		$AmazonUrl = $Matches.AmazonUrl
		$GoodsUrl = $AmazonUrl + $DPUrl
	}

	echo $GoodsUrl
	$GoodsUrl | Set-Clipboard

	if($Check){
		if( Test-Path $ChromePath ){
			if( $GoodsUrl -match "`.com" ){
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
