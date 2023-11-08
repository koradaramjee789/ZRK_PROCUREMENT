@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRK_I_SUP_CON_DATA'
define root view entity ZRK_C_SUP_CON_DATA
provider contract transactional_query
  as projection on ZRK_I_SUP_CON_DATA
{
  key SupNo,
  key SupConID,
  Name,
  AppAccess,
  @Semantics.eMail.address
  EmailID
  
}
