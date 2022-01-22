@EndUserText.label: 'Projection for purchase contract'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define root view entity ZRK_C_PUR_CON as projection on Zrk_I_Pur_Con {
    key ConUuid,
    ObjectId,
    Description,
    Buyer,
    Supplier,
    SupConId,
    CompCode,
    StatCode,
    ValidFrom,
    ValidTo,
    FiscalYear,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LoclLastChangedAt
}
