@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for financial year'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZRK_I_FISCAL_YEAR 
as select from zrk_md_fisc_year {
     key  fisclyear as fiscal_year
      
      }
