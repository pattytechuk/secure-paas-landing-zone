@description('Name of the SQL Server')
param sqlServerName string = 'my-sql-server1'

@description('SQL admin username')
param sqlAdminUsername string = 'pattyadmin'

@description('Azure region for resources')
param location string = resourceGroup().location

@description('Key Vault name (must already exist)')
param keyVaultName string = 'my-keyvault1'

@description('Secret name inside Key Vault for SQL password')
param sqlPasswordSecretName string = 'SqlAdminPassword'

// Reference the existing Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2024-07-01' existing = {
  name: keyVaultName
}

// Reference the existing secret inside Key Vault
resource sqlAdminPassword 'Microsoft.KeyVault/vaults/secrets@2024-07-01' existing = {
  parent: keyVault
  name: sqlPasswordSecretName
}

// SQL Server
resource sqlServer 'Microsoft.Sql/servers@2024-07-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminUsername
    administratorLoginPassword: sqlAdminPassword.properties.value
  }
}

// SQL Database (basic tier for lab/demo)
resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-07-01-preview' = {
  name: '${sqlServer.name}/mydb'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {}
}
