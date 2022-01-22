@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for company code'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRK_I_COMP_CODE as select from ZRK_I_PLANT {
 key cast('' as char4 ) as CompCode 
}
