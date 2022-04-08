@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZRK_supp_det'
define root view entity ZRK_I_SUP_DATA
  as select from zrk_md_supplier as supplier
{
  key sup_no as SupNo,
  name as Name
  
}
