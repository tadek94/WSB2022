param skuName string = 'S1'
param skuCapacity int = 1
param location string = resourceGroup().location
param appName string = uniqueString(resourceGroup().id)
param appName2 string = uniqueString(resourceGroup().name)

var appServicePlanName = toLower('asp-${appName}')
var webSiteName = toLower('wapp-${appName}')
var webSiteName2 = toLower('wapp2-${appName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName // app serivce plan name
  location: location // Azure Region
  sku: {
    name: skuName
    capacity: skuCapacity
  }
  tags: {
    displayName: 'HostingPlanWsb'
    ProjectName: appName
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName // Globally unique app serivce name
  dependsOn: [
    appServicePlan
  ]
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    displayName: 'WebsiteWsb'
    ProjectName: appName
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
    }
  }
}

resource appService2 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName2 // Globally unique app serivce name
  dependsOn: [
    appServicePlan
  ]
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    displayName: 'WebsiteWsb2'
    ProjectName: appName2
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
    }
  }
}
