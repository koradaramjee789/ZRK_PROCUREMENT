@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZRK_GEN_PUR_CON_H'
@Metadata.allowExtensions: true
define root view entity ZRK_I_PUR_CON_H
  as select from zrk_t_pur_con_h as PCHead
{
  key ord_uuid as OrdUUID,
  object_id as ObjectID,
  description as Description,
  buyer as Buyer,
  supplier as Supplier,
  sup_con_id as SupConID,
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
  locl_last_changed_at as LoclLastChangedAt
  
}
