@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Conditions at item level'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZRK_I_PUR_COND_I 
as select from zrk_t_pur_cond_i 
association to parent ZRK_I_PUR_CON_I as _PurConItem 
on $projection.ConItemUuid = _PurConItem.ConItemUuid

association [1..1] to ZRK_I_PUR_CON_UD as _PurCon
    on $projection.ConUuid = _PurCon.ConUuid
{
    key cond_uuid as CondUuid,
    con_uuid as ConUuid,
    con_item_uuid as ConItemUuid,
    cond_type as CondType,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    currency as Currency,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    locl_last_changed_at as LoclLastChangedAt,    
    
    _PurConItem,
    _PurCon

}
