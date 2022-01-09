@AbapCatalog.sqlViewName: 'ZRK_V_SUP_CON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for supplier contact'
define view ZRK_I_SUP_CON as select from zrk_md_sup_con {
    key sup_no as SupNo,
    key sup_con_id as SupConId,
    name as Name,
    app_access as AppAccess,
    email_id as EmailId
}
