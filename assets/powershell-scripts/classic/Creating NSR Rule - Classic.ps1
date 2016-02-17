New-AzureNetworkSecurityGroup -Name "NSG-FrontEnd" -Location uswest `
    -Label "Front end subnet NSG"

#Create a security rule allowing access from the Internet to port 3389. 
Get-AzureNetworkSecurityGroup -Name "NSG-FrontEnd" `
| Set-AzureNetworkSecurityRule -Name rdp-rule `
    -Action Allow -Protocol TCP -Type Inbound -Priority 100 `
    -SourceAddressPrefix Internet  -SourcePortRange '*' `
    -DestinationAddressPrefix '*' -DestinationPortRange '3389' 

#rule 2 Create a security rule allowing access from the Internet to port 80. 
Get-AzureNetworkSecurityGroup -Name "NSG-FrontEnd" `
| Set-AzureNetworkSecurityRule -Name web-rule `
    -Action Allow -Protocol TCP -Type Inbound -Priority 200 `
    -SourceAddressPrefix Internet  -SourcePortRange '*' `
    -DestinationAddressPrefix '*' -DestinationPortRange '80' 