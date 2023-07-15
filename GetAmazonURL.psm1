############################################################
# Reject Amazon URL
############################################################
function GetAmazonURL(){
	$FullURL = Get-Clipboard
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

	$DPUrl = "/dp/" + $Matches.DPUrl

	$dummy = $FullURL -match "(?<AmazonUrl>https://.+?)/"
	$AmazonUrl = $Matches.AmazonUrl
	$GoodsUrl = $AmazonUrl + $DPUrl
	echo $GoodsUrl
	$GoodsUrl | Set-Clipboard
}
