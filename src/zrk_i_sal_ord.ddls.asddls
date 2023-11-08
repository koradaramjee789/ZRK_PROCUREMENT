@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for sales order'
define root view entity ZRK_I_SAL_ORD as select from zrk_t_sal_ord_h
composition [0..* ] of ZRK_I_SAL_ORD_I as _Items  
{
    key object_id as ObjectId,
    description as Description,
    buyer as Buyer,
    stat_code as StatCode,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt ,
    _Items // Make association public
}
