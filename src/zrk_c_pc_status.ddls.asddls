//@AbapCatalog.sqlViewName: 'ZRK_V_PCSTATUS'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for status'
@Metadata.allowExtensions: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZRK_C_PC_STATUS 
//with parameters p_app : zrk_app_code
as select from zrk_md_status {
 //   key app as App,
 @UI.textArrangement: #TEXT_ONLY
 @ObjectModel.text.element: ['Status']
    key code as Code,
    status as Status
}
where app = 'PUR_CON'
