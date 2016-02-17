
$SubscriptionName="MSDNAzureUltimate"           #"<subscription name>"
$StorageAccountName="teststa1122016"                #"<storage account name>"
$Location = "Japan East"                 #"<Location>"
$ResourceGroupName = "RGFORVNET2"

Select-AzureSubscription -SubscriptionName $SubscriptionName –Current
# Create a new storage account.
New-AzureRmStorageAccount -Location $Location -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -Type Standard_RAGRS