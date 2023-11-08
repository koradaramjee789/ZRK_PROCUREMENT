@EndUserText.label: 'Supplier master data Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZRK_I_SupplierMasterData_S
  as select from I_Language
    left outer join ZRK_MD_SUPPLIER on 0 = 0
  composition [0..*] of ZRK_I_SupplierMasterData as _SupplierMasterData
{
  key 1 as SingletonID,
  _SupplierMasterData,
  max( ZRK_MD_SUPPLIER.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
