@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'App for Supplier contact master'
define root view entity ZRK_I_SUP_CON_DATA
  as select from zrk_md_sup_con as SupConData
{
  key sup_no as SupNo,
  key sup_con_id as SupConID,
  name as Name,
  app_access as AppAccess,
  email_id as EmailID,
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
