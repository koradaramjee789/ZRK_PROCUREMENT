@EndUserText.label: 'Project view for contract item'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZRK_C_PUR_CON_I 

as projection on ZRK_I_PUR_CON_I as _PurConItem
{
    
    key ConItemUuid,
    ConUuid,
    ItemNo,
    Description,
    PartNo,
    Unit,
    CommCode,
    Quantity,
    Price,
    Currency,
    SrcReqNo,
    @EndUserText.label: 'PR Item No'
    SrcReqItem,
    SrcOrdNo,
    SrcOrdItem,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LoclLastChangedAt,
    /* Associations */
    _PurCon : redirected to parent ZRK_C_PUR_CON_UD,
    _PurConItemCond : redirected to composition child zrk_c_pur_cond_i
}
