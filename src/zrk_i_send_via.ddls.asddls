@AbapCatalog.sqlViewName: 'ZRK_SENDVIA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Send Via'
@ObjectModel.resultSet.sizeCategory: #XS
define view ZRK_I_SEND_VIA as select from zrk_md_send_via {
 @UI.textArrangement: #TEXT_ONLY
 @ObjectModel.text.element: ['SentViaText']
    key send_via as SendVia,
    sent_via_text as SentViaText
}
