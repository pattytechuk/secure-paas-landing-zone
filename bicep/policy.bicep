// Azure Policy Enforcement - use HTTPS on App Service

resource enforceHttpsPolicy 'Microsoft.Authorization/policyAssignments@2023-03-01' = {
  name: 'enforce-appservice-https'
  scope: resourceGroup()
  properties: {
    displayName: 'Enforce HTTPS on App Services'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/af0b0b24-5c8b-4f79-8b15-7e4c97c1f6a4' // Built-in policy
  }
}
