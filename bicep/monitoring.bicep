// Log Analytics workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2024-05-01' = {
  name: 'landingzone-law'
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}

// App Service diagnostic logs
resource appDiag 'Microsoft.Insights/diagnosticSettings@2024-07-01' = {
  name: 'webapp-diagnostics'
  scope: webApp
  properties: {
    workspaceId: logAnalytics.id
    logs: [
      { category: 'AppServiceHTTPLogs'; enabled: true }
      { category: 'AppServiceConsoleLogs'; enabled: true }
    ]
    metrics: [
      { category: 'AllMetrics'; enabled: true }
    ]
  }
}

// SQL Server diagnostic logs
resource sqlDiag 'Microsoft.Insights/diagnosticSettings@2024-07-01' = {
  name: 'sqlserver-diagnostics'
  scope: sqlServer
  properties: {
    workspaceId: logAnalytics.id
    logs: [
      { category: 'SQLSecurityAuditEvents'; enabled: true }
      { category: 'SQLInsights'; enabled: true }
    ]
    metrics: [
      { category: 'AllMetrics'; enabled: true }
    ]
  }
}
