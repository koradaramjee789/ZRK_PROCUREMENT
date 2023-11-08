@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRK_I_SUP_DATA'
define root view entity ZRK_UI_MD_SUP
  as projection on ZRK_I_SUP_DATA
{
  key supno,
  name
  
}
