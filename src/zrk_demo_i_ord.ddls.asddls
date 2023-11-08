@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '##GENERATED Demo orders'
define root view entity ZRK_DEMO_I_ORD
  as select from zrk_demo_ord as Ord
{
  key ord_uuid as OrdUUID,
  object_id as ObjectID,
  description as Description,
  buyer as Buyer,
  supplier as Supplier,
  stat_code as StatCode,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
  
}
