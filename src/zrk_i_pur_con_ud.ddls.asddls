@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZRK_I_PUR_CON_UD'
define root view entity ZRK_I_PUR_CON_UD as select from zrk_t_pur_con as PurCon

composition [0..*] of ZRK_I_PUR_CON_I as _PurConItem 

association [1..1] to ZRK_I_SUPPLIER as Supplier_f4 on $projection.Supplier = Supplier_f4.SupNo
association [1..1] to ZRK_I_BUYER as BuyerF4 on $projection.Buyer = BuyerF4.BuyerId
association [0..1] to zrk_md_send_via as SendViaF4 on $projection.SendVia = SendViaF4.send_via
 

{
    key con_uuid as ConUuid,
    object_id as ObjectId,
    description as Description,
    buyer as Buyer,
    supplier as Supplier,
    sup_con_id as SupConId,
    comp_code as CompCode,
    stat_code as StatCode,
    fiscl_year as FisclYear,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    send_via as SendVia,
     SendViaF4.sent_via_text,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    locl_last_changed_at as LoclLastChangedAt,
    
    _PurConItem,
    
    Supplier_f4,
    BuyerF4,
    SendViaF4

}
