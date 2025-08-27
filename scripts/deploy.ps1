# The following are all the PowerShell scripts used

Connect-AzAccount
$rgName = "SecurePaaSLandingZone"

# Deploy hub v-net
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile "../bicep/hub-vnet.bicep" 

# Deploy spoke v-nets
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile "../bicep/spoke-vnet.bicep" 

# Deploy VNet Peering
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile "../bicep/vnet-peering.bicep" 

# Deploy PaaS resources
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile "../bicep/app-service.bicep"
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile "../bicep/sql-database.bicep" 
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile "../bicep/key-vault.bicep" 
