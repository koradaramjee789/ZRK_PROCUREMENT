@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view for contract item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRK_I_PUR_CON_I as select from zrk_t_pur_con_i as PurConItem 
composition [0..*] of ZRK_I_PUR_COND_I as _PurConItemCond 
association to parent ZRK_I_PUR_CON_UD as _PurCon on $projection.ConUuid = _PurCon.ConUuid
{
    
    key con_item_uuid as ConItemUuid,
    con_uuid as ConUuid,
    item_no as ItemNo,
    description as Description,
    part_no as PartNo,
    unit as Unit,
    comm_code as CommCode,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    quantity as Quantity,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    currency as Currency,
    src_req_no as SrcReqNo,
    src_req_item as SrcReqItem,
    src_ord_no as SrcOrdNo,
    src_ord_item as SrcOrdItem,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    locl_last_changed_at as LoclLastChangedAt,
    
    _PurCon,
    _PurConItemCond
}
