param location string = 'uksouth'

// App Service plan
resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: 'dev-appserviceplan'
  location: location
  sku: { name: 
      'P1v2'; 
        tier: 'Free'; 
        size: 'F1' }
  properties: { 
    reserved: true 
  }
}

// Web App
resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: 'dev-webapp'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

// Private endpoint for the web app
resource appPrivateEndpoint 'Microsoft.Network/privateEndpoints@2024-07-01' = {
  name: 'pe-webapp'
  location: location
  properties: {
    subnet: { id: '/subscriptions/<subId - removed>/resourceGroups/SecurePaaSLandingZone/providers/Microsoft.Network/virtualNetworks/vnet-apps/subnets/PrivateEndpointSubnet' }
    privateLinkServiceConnections: [
      {
        name: 'webAppConnection'
        properties: {
          privateLinkServiceId: webApp.id
          groupIds: ['sites']
        }
      }
    ]
  }
}
