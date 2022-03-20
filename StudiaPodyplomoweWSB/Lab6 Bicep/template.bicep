param location string = resourceGroup().location
@minLength(3)
@maxLength(11)
param storageNamePrefix string

@minLength(3)
@maxLength(11)
param storageNamePrefix2 string

@allowed([
  'Standard_LRS'
])
param storageSKU string

var storageName = '${toLower(storageNamePrefix)}${uniqueString(resourceGroup().id)}'
var storageName2 = '${toLower(storageNamePrefix2)}${uniqueString(resourceGroup().id)}'

resource storageaccount_res 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  properties:{
    allowBlobPublicAccess:false
    accessTier:'Hot'
    allowSharedKeyAccess:false
  }
  sku: {
    name: storageSKU
  }

}

resource storageaccount_res2 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName2
  location: location
  kind: 'StorageV2'
  properties:{
    allowBlobPublicAccess:false
    accessTier:'Hot'
    allowSharedKeyAccess:false
  }
  sku: {
    name: storageSKU
  }

}

output bloburl string = storageaccount_res.properties.primaryEndpoints.blob 
