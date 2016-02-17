$SubscriptionName="MSDNAzureUltimate"           #"<subscription name>"
$StorageAccountName="teststa1122016"                #"<storage account name>"
Set-AzureSubscription -SubscriptionName $SubscriptionName -CurrentStorageAccountName $StorageAccountName

#Get-AzureVMImage | select ImageFamily -Unique  #Get the unique VM images using this script.


$family="Windows Server 2012 R2 Datacenter"#"<ImageFamily value>"
$image=Get-AzureVMImage | where { $_.ImageFamily -eq $family } | sort PublishedDate -Descending | select -ExpandProperty ImageName -First 1

$vmname="mywindowvm2016"#"<machine name>"
$vmsize="Small"   #"<Specify one: Small, Medium, Large, ExtraLarge, A5, A6, A7, A8, A9>"
$vm1=New-AzureVMConfig -Name $vmname -InstanceSize $vmsize -ImageName $image

$cred=Get-Credential -Message "Type the name and password of the local administrator account."
$vm1 | Add-AzureProvisioningConfig -Windows -AdminUsername $cred.GetNetworkCredential().Username -Password $cred.GetNetworkCredential().Password

$CloudServiceName = "mylinuxvmcloudservice1122016"

New-AzureVM –ServiceName $CloudServiceName -VMs $vm1
