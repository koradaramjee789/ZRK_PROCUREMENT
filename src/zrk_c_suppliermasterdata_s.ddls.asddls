@EndUserText.label: 'Maintain Supplier master data Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZRK_C_SupplierMasterData_S
  provider contract transactional_query
  as projection on ZRK_I_SupplierMasterData_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _SupplierMasterData : redirected to composition child ZRK_C_SupplierMasterData
  
}
