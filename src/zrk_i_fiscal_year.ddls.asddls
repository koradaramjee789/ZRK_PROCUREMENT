@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for financial year'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZRK_I_FISCAL_YEAR as select from ZRK_I_PLANT {
     key cast( '' as abap.char(4)) as fiscal_year
      
      }
