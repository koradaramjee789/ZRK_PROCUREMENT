@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRK_I_APR_DET'
define root view entity ZRK_C_APR_DET
  as projection on ZRK_I_APR_DET
{
  key objecttype,
  key objectid,
  description,
  toalamount,
  currencykey,
  status,
  comments,
  locllastchangedat
  
}
