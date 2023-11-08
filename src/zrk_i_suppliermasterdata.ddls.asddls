@EndUserText.label: 'Supplier master data'
@AccessControl.authorizationCheck: #CHECK
define view entity ZRK_I_SupplierMasterData
  as select from ZRK_MD_SUPPLIER
  association to parent ZRK_I_SupplierMasterData_S as _SupplierMasterDaAll on $projection.SingletonID = _SupplierMasterDaAll.SingletonID
{
  key SUP_NO as SupNo,
  NAME as Name,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  1 as SingletonID,
  _SupplierMasterDaAll
  
}
