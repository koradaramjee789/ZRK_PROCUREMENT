@EndUserText.label: 'Consumption view for sales order'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZRK_C_SAL_ORD 
provider contract transactional_query
as projection on ZRK_I_SAL_ORD 

{
    key ObjectId,
    Description,
    Buyer,
    StatCode,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Items : redirected to composition child ZRK_C_SAL_ORD_I
}
