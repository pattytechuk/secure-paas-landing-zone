param location string = 'uksouth'

resource spokeVNet1 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: 'vnet-apps'
  location: location
  properties: {
    addressSpace: { addressPrefixes: ['10.1.0.0/16'] }
    subnets: [
      { name: 'AppSubnet'; properties: { addressPrefix: '10.1.1.0/24' } }
      { name: 'PrivateEndpointSubnet'; properties: { addressPrefix: '10.1.3.0/24' } }
    ]
  }
}

resource spokeVNet2 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: 'vnet-data'
  location: location
  properties: {
    addressSpace: { addressPrefixes: ['10.2.0.0/16'] }
    subnets: [
      { name: 'DBSubnet'; properties: { addressPrefix: '10.2.1.0/24' } }
      { name: 'PrivateEndpointSubnet'; properties: { addressPrefix: '10.2.3.0/24' } }
    ]
  }
}
