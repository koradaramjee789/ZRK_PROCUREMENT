@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Project for unmanaged draft'
@Metadata.allowExtensions: true
define root view entity ZRK_C_PUR_CON_UD 
provider contract transactional_query
as projection on ZRK_I_PUR_CON_UD
{
    key ConUuid,
    ObjectId,
    Description,
    @ObjectModel.text.element: ['BuyerName']
    Buyer,
    BuyerF4.Name as BuyerName ,
    @ObjectModel.text.element: ['SupplierName']
    Supplier,
    Supplier_f4.Name as SupplierName,
    SupConId,
    SendVia,
   sent_via_text,
    CompCode,
    StatCode,
    FisclYear,
    ValidFrom,
    ValidTo,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LoclLastChangedAt,
    
    _PurConItem : redirected to composition child ZRK_C_PUR_CON_I,
    
    Supplier_f4,
    SendViaF4
    
}
