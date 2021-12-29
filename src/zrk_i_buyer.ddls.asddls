@AbapCatalog.sqlViewName: 'ZRK_V_BUYER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for buyer'
define view ZRK_I_BUYER as select from zrk_md_buyer {
    @UI.hidden: true
    @ObjectModel.text.element: ['Name']
    key buyer_id as BuyerId,
    name as Name,
    email_id as EmailId
}
