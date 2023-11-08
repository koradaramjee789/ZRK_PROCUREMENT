@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZRK_DEMO_I_ORD'
define root view entity ZRK_DEMO_C_ORD
  provider contract transactional_query
  as projection on ZRK_DEMO_I_ORD
{
  key OrdUUID,
  ObjectID,
  Description,
  Buyer,
  Supplier,
  StatCode,
  LocalLastChangedAt
  
}
