@EndUserText.label: 'Projection entity for item conditions'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZRK_C_PUR_COND_I 
as projection on ZRK_I_PUR_COND_I {
    key CondUuid,
    ConUuid,
    ConItemUuid,
    CondType,
    ValidFrom,
    ValidTo,
    Price,
    Currency,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LoclLastChangedAt,    
    /* Associations */
    _PurConItem : redirected to parent ZRK_C_PUR_CON_I,
    
    _PurCon : redirected to ZRK_C_PUR_CON_UD
}
