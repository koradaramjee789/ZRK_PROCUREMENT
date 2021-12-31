@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZRK_GEN_APR_DET'
define root view entity ZRK_I_APR_DET
  as select from zrk_apr_det as Approval
{
  key object_type as ObjectType,
  key object_id as ObjectID,
  description as Description,
  @Semantics.amount.currencyCode: 'CurrencyKey'
  toal_amount as ToalAmount,
  currency_key as CurrencyKey,
  status as Status,
  comments as Comments,
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
