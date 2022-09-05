############################################################
# Amazon URL のノイズを取り除く
############################################################
function GetAmazonURL(){
	$FullURL = Get-Clipboard
	$dummy = $FullURL -match "(?<DPUrl>/dp/.+?)/"
	if($dummy -eq $false ){
		$dummy = $FullURL -match "(?<DPUrl>/dp/.+?)\?"
	}
	$DPUrl = $Matches.DPUrl
	$dummy = $FullURL -match "(?<AmazonUrl>https://.+?)/"
	$AmazonUrl = $Matches.AmazonUrl
	$GoodsUrl = $AmazonUrl + $DPUrl
	echo $GoodsUrl
	$GoodsUrl | Set-Clipboard
}
