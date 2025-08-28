param hubVNetId string
param spokeVNetId string

resource hubToSpoke 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  name: 'vnet-hub/spoke-peering'
  parent: hubVNetId
  properties: {
    remoteVirtualNetwork: { id: spokeVNetId }
    allowForwardedTraffic: true
    allowGatewayTransit: true
  }
}

resource spokeToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  name: 'vnet-spoke/hub-peering'
  parent: spokeVNetId
  properties: {
    remoteVirtualNetwork: { id: hubVNetId }
    allowForwardedTraffic: true
    useRemoteGateways: true
  }
}
