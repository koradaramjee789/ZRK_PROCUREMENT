@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Project for unmanaged draft'
@Metadata.allowExtensions: true
define root view entity ZRK_C_PUR_CON_UD as projection on ZRK_I_PUR_CON_UD
{
    key ConUuid,
    ObjectId,
    Description,
    Buyer,
    Supplier,
    SupConId,
    CompCode,
    StatCode,
    FisclYear,
    ValidFrom,
    ValidTo,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LoclLastChangedAt
    
}
