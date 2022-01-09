@AbapCatalog.sqlViewName: 'ZRK_V_STATUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for status'
define view ZRK_I_STATUS as select from zrk_md_status {
    key app as App,
    key code as Code,
    status as Status
}
