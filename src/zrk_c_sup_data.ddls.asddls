@EndUserText.label: 'ZRK_C_SUP_DATA'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZRK_C_SUP_DATA 
provider contract transactional_query
as projection on ZRK_I_SUP_DATA {
    key SupNo,
    Name,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt
}
