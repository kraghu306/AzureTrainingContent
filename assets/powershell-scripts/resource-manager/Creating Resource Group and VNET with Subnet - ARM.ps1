Add-AzureRmAccount
New-AzureRmResourceGroup -Name RGFORVNET2 -Location 'Japan East'
$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name 'Subnet1' -AddressPrefix '10.2.1.0/28'
New-AzureRmVirtualNetwork -Name Vnet2 -ResourceGroupName RGFORVNET2 -Location 'Japan East' -AddressPrefix 10.2.0.0/16 -Subnet $subnet1
