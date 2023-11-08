@EndUserText.label: 'Consumption view for sales order item'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZRK_C_SAL_ORD_I 
as projection on ZRK_I_SAL_ORD_I {
    key ObjectId,
    key ItemNo,
    Description,
    PartNo,
    Unit,
    CommCode,
    Plant,
    Supplier,
    Quantity,
    Price,
    Currency,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _Header : redirected to parent ZRK_C_SAL_ORD 
}
