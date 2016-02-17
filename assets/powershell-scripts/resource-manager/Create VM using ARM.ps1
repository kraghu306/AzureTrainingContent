$rgName="RGFORVNET2"
$locName="Japan East"
$saName="teststa1122016"

#This script is required select the parameters
$vnetName="Vnet2"
$subnetIndex=0
$vnet=Get-AzureRMVirtualNetwork -Name $vnetName -ResourceGroupName $rgName

$nicName="LOB07-NIC"
$domName="contoso-vm-lob07"
$pip=New-AzureRmPublicIpAddress -Name $nicName -ResourceGroupName $rgName -DomainNameLabel $domName -Location $locName -AllocationMethod Dynamic
$nic=New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $locName -SubnetId $vnet.Subnets[$subnetIndex].Id -PublicIpAddressId $pip.Id
    
$vmName="LOB07"
$vmSize="Standard_A3"
$avName="WEB_AS"
#$avSet=Get-AzureRmAvailabilitySet –Name $avName –ResourceGroupName $rgName
$vm=New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

$pubName="MicrosoftWindowsServer"
$offerName="WindowsServer"
$skuName="2012-R2-Datacenter"
$cred=Get-Credential -Message "Type the name and password of the local administrator account."
$vm=Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vm=Set-AzureRmVMSourceImage -VM $vm -PublisherName $pubName -Offer $offerName -Skus $skuName -Version "latest"
$vm=Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

$diskName="OSDisk"
$storageAcc=Get-AzureRmStorageAccount -ResourceGroupName $rgName -Name $saName
$osDiskUri=$storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $vmName + $diskName  + ".vhd"
$vm=Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage
New-AzureRmVM -ResourceGroupName $rgName -Location $locName -VM $vm