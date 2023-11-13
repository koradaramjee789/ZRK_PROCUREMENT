@EndUserText.label: 'Projection for purchase requisition header'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.semanticKey: ['ObjectId']
@Metadata.allowExtensions: true
define root view entity ZRK_C_PUR_REQ_H 
provider contract transactional_query
as projection on ZRK_I_PUR_REQ_H 

{
    key ObjectId,
    Description,
    StatCode,
    @ObjectModel.text.element: ['BuyerName']
    Buyer,
    _BuyerF4.Name as BuyerName,
     @Semantics.user.createdBy: true
    CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    CreatedAt,
    @Semantics.user.lastChangedBy: true
    LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    LastChangedAt,
    /* Associations */
    _PRItem : redirected to composition child ZRK_C_PUR_REQ_I,
    _BuyerF4 
}
