@EndUserText.label: 'Maintain Supplier master data'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZRK_C_SupplierMasterData
  as projection on ZRK_I_SupplierMasterData
{
  key SupNo,
  Name,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _SupplierMasterDaAll : redirected to parent ZRK_C_SupplierMasterData_S
  
}
