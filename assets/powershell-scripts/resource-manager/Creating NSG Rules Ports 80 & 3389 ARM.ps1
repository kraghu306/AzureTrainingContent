
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 3389

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Allow HTTP" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 101 `
-SourceAddressPrefix Internet -SourcePortRange * `
-DestinationAddressPrefix * -DestinationPortRange 80

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName RGFORVNET2 -Location "Japan East" -Name "NSG-FrontEnd" `
-SecurityRules $rule1,$rule2

$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName RGFORVNET2 -Name Vnet2
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name Subnet1 `
    -AddressPrefix 10.2.1.0/28 -NetworkSecurityGroup $nsg

#To save the new vnet settings below script is important to run
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet


    #refer the below link if there is any doubts
    #https://azure.microsoft.com/en-in/documentation/articles/virtual-networks-create-nsg-arm-ps/