$myJson = Get-Content .\Sample1_Config.json -Raw | ConvertFrom-Json 

$Client = $myJson.Client

$LocationFilePhrase = $myJson.Config.LocationFile.Phrase
$LocationFileArchive = $myJson.Config.LocationFile.Archive
$LocationFileShare = $myJson.Config.LocationFile.Share

$PayCodeFilePhrase = $myJson.Config.PayCodeFile.Phrase
$PayCodeFileArchive = $myJson.Config.PayCodeFile.Archive
$PayCodeFileShare = $myJson.Config.PayCodeFile.Share

if ($LocationFileShare -eq $null) {
    $LocationFileShare = $false
}
if ($PayCodeFileShare -eq $null) {
    $PayCodeFileShare = $false
}



Get-ChildItem -Recurse -Depth 0 | ? {($_.Name -like ('*' + $LocationFilePhrase + '*') -and $LocationFileShare) -or ($_.Name -like ('*' + $PayCodeFilePhrase + '*') -and $PayCodeFileShare)} | Copy-Item -Destination C:\SplitLab\Share

Get-ChildItem -Recurse -Depth 0 | ? {($_.Name -like ('*' + $LocationFilePhrase + '*') -and $LocationFileArchive) -or ($_.Name -like ('*' + $PayCodeFilePhrase + '*') -and $PayCodeFileArchive)} | Move-Item -Destination C:\SplitLab\Archive