@EndUserText.label: 'Projection for purchase requisition Item'
@AccessControl.authorizationCheck: #CHECK
define view entity ZRK_C_PUR_REQ_I 
as projection on ZRK_I_PUR_REQ_I {
    key ObjectId,
    key ItemNo,
    Description,
    PartNo,
    Unit,
    CommCode,
    Plant,
    @ObjectModel.text.element: ['SupplierName']
    Supplier,
    _SupplierF4.Name as SupplierName,
    Quantity,
    Price,
    Currency,
     @Semantics.user.createdBy: true
    CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    CreatedAt,
    @Semantics.user.lastChangedBy: true
    LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    LastChangedAt,
    /* Associations */
    _PRHead : redirected to parent ZRK_C_PUR_REQ_H,
    _plant ,
    _partsF4,
    _SupplierF4
    
}
