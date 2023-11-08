@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for sales order item'
define view entity ZRK_I_SAL_ORD_I as select from zrk_t_sal_ord_i
association to parent ZRK_I_SAL_ORD as _Header 
    on $projection.ObjectId = _Header.ObjectId 
    {
    key object_id as ObjectId,
    key item_no as ItemNo,
    description as Description,
    part_no as PartNo,
    unit as Unit,
    comm_code as CommCode,
    plant as Plant,
    supplier as Supplier,
    quantity as Quantity,
    price as Price,
    currency as Currency,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt ,
    _Header // Make association public
}
