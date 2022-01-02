@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRK_I_PUR_CON_H'
define root view entity ZRK_C_PUR_CON_H
  as projection on ZRK_I_PUR_CON_H
{
  key orduuid,
  objectid,
  description,
  buyer,
  supplier,
  supconid,
  statcode,
  locllastchangedat
  
}
