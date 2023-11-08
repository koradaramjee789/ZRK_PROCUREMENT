@AbapCatalog.sqlViewName: 'ZRK_V_STATUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for status'
@Metadata.allowExtensions: true
define view ZRK_I_STATUS 
//with parameters p_app : zrk_app_code
as select from zrk_md_status {
    key app as App,
    key code as Code,
    status as Status
}
//where app = $parameters.p_app
