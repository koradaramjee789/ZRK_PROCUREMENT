@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZRK_supp_det'
define root view entity ZRK_I_SUP_DATA
  as select from zrk_md_supplier as supplier
{
  key sup_no as SupNo,
  name as Name,
        @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //total ETag field
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt
}
