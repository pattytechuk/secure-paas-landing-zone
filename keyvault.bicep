param location string = 'uksouth'

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: 'dev-keyvault'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: { 
      family: 'A'; 
      name: 'standard' }
    enablePurgeProtection: true
    enableSoftDelete: true
    networkAcls: { defaultAction: 'Deny'; bypass: 'AzureServices' }
  }
}

resource kvPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-06-01' = {
  name: 'pe-keyvault'
  location: location
  properties: {
    subnet: { id: '/subscriptions/<subId>/resourceGroups/SecurePaaSLandingZone/providers/Microsoft.Network/virtualNetworks/vnet-data/subnets/PrivateEndpointSubnet' }
    privateLinkServiceConnections: [
      {
        name: 'keyVaultConnection'
        properties: {
          privateLinkServiceId: keyVault.id
          groupIds: ['vault']
        }
      }
    ]
  }
}
