
$deployName = "S4HanaDemoDeployment"
$updatedTemplateFilePath = "https://github.com/zeulatek/dualnrg-azure/blob/master/devtestlabs/Scripts/environmentdeploy.json"
$DevTestLabName = "S4Hana-dtl"
$machineUserName = "testuser"
$machinePassword = ConvertTo-SecureString 'P@ss1worD' -AsPlainText -Force
$subId = "b47e2e67-6ce6-430d-b41a-c439e1ff22fb"

Login-AzureRmAccount

Set-AzureRmContext -SubscriptionId $subId | Out-Null

$ResourceGroupName = (Find-AzureRmResource -ResourceType 'Microsoft.DevTestLab/labs' | Where-Object { $_.Name -eq $DevTestLabName}).ResourceGroupName

Write-Output "Starting Environment creation. $(Get-Date)"

$vmDeployResult = New-AzureRmResourceGroupDeployment -Name $deployName -ResourceGroupName $ResourceGroupName -TemplateFile $updatedTemplateFilePath -armParaName $machineUserName -armParaPassword $machinePassword

Write-Output "Environment creation completed. $(Get-Date)"
