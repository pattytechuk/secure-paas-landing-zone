param location string = 'uksouth'

resource hubVNet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'vnet-hub'
  location: location
  properties: {
    addressSpace: { addressPrefixes: ['10.0.0.0/16'] }
    subnets: [
      { name: 'AzureFirewallSubnet'; properties: { addressPrefix: '10.0.1.0/24' } }
      { name: 'BastionSubnet'; properties: { addressPrefix: '10.0.2.0/24' } }
    ]
  }
