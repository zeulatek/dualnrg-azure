
$deployName = "S4HanaDemoDeployment"
$updatedTemplateFilePath = "c:\ignitedemo\environmentdeploy.json"
$DevTestLabName = "S4Hana-dtl"
$machineUserName = "testuser"
$machinePassword = ConvertTo-SecureString 'P@ss1worD' -AsPlainText -Force
$subId = "b47e2e67-6ce6-430d-b41a-c439e1ff22fb"

Login-AzureRmAccount

New-Item -Path "C:\ignitedemo" -ItemType Directory -Force

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zeulatek/dualnrg-azure/master/devtestlabs/Scripts/environmentdeploy.json" -OutFile $updatedTemplateFilePath

Set-AzureRmContext -SubscriptionId $subId | Out-Null

$ResourceGroupName = (Find-AzureRmResource -ResourceType 'Microsoft.DevTestLab/labs' | Where-Object { $_.Name -eq $DevTestLabName}).ResourceGroupName

Write-Output "Starting Environment creation. $(Get-Date)"

$vmDeployResult = New-AzureRmResourceGroupDeployment -Name $deployName -ResourceGroupName $ResourceGroupName -TemplateFile $updatedTemplateFilePath -armParaName $machineUserName -armParaPassword $machinePassword

Write-Output "Environment creation completed. $(Get-Date)"
