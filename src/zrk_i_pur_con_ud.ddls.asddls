@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZRK_I_PUR_CON_UD'
define root view entity ZRK_I_PUR_CON_UD as select from zrk_t_pur_con as PurCon

composition [0..*] of ZRK_I_PUR_CON_I as _PurConItem 
composition [0..*] of zrk_i_pur_con_att as Attachments
association [1..1] to ZRK_I_SUPPLIER as Supplier_f4 on $projection.Supplier = Supplier_f4.SupNo
association [1..1] to ZRK_I_BUYER as BuyerF4 on $projection.Buyer = BuyerF4.BuyerId
association [0..1] to zrk_md_send_via as SendViaF4 on $projection.SendVia = SendViaF4.send_via
association [1..1] to ZRK_C_PC_STATUS as StatusF4 on $projection.StatCode = StatusF4.Code
 

{

    key con_uuid as ConUuid,
    @Consumption.semanticObject: 'PurCon'
    object_id as ObjectId,
    description as Description,
    description as DescriptionDisp,
    buyer as Buyer,
    buyer as BuyerDisp,
    supplier as Supplier,
    sup_con_id as SupConId,
    comp_code as CompCode,
    stat_code as StatCode,
    StatusF4.Status as Status,
    fiscl_year as FisclYear,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    target_value as TargetValue,
    currency,
    send_via as SendVia,
    SendViaF4.sent_via_text,
    version_no as VersionNo,
    '' as ReleasedAtLeastOnce,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZRK_CL_VE_PUR_CON'
    cast( '' as abap_boolean) as DraftFlag,
    urgent_flag,
    urgent_comments,
    cast( ( case when urgent_flag = '' then 'X' else '' end   ) as abap_boolean) as AdhocUrgent,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    locl_last_changed_at as LoclLastChangedAt,
    
    _PurConItem,
    Attachments,
    
    Supplier_f4,
    BuyerF4,
    SendViaF4,
    StatusF4

}
