$SubscriptionName="MSDNAzureUltimate"           #"<subscription name>"
$StorageAccountName="teststa1122016"                #"<storage account name>"
Set-AzureSubscription -SubscriptionName $SubscriptionName -CurrentStorageAccountName $StorageAccountName

#Get-AzureVMImage | select ImageFamily -Unique  #Get the unique VM images using this script.


$family="Ubuntu Server 12.10"#"<ImageFamily value>"
$image=Get-AzureVMImage | where { $_.ImageFamily -eq $family } | sort PublishedDate -Descending | select -ExpandProperty ImageName -First 1
$vmname="mytestlinusvm1122016"#"<machine name>"
$vmsize="Small"   #"<Specify one: Small, Medium, Large, ExtraLarge, A5, A6, A7, A8, A9>"
$vm1=New-AzureVMConfig -Name $vmname -InstanceSize $vmsize -ImageName $image
$cred=Get-Credential -Message "Type the name and password of the initial Linux account."
$vm1 | Add-AzureProvisioningConfig -Linux -LinuxUser $cred.GetNetworkCredential().Username -Password $cred.GetNetworkCredential().Password

#Creating a new Cloud service
$CloudServiceName = "mylinuxvmcloudservice1122016"
$CloudLabel = "mylinuxvmcloudservice1122016"
New-AzureService -ServiceName $CloudServiceName -Location "West US" -Label $CloudLabel

$vnetname= "TestVnet-1" #"<name of the virtual network>"
New-AzureVM –ServiceName $CloudServiceName -VMs $vm1