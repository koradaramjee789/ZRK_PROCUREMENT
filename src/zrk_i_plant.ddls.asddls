@AbapCatalog.sqlViewName: 'ZRK_IPLANT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data definition for plant'
@Metadata.allowExtensions: true
define view ZRK_I_PLANT as select from zrk_md_plant {
@ObjectModel.text.element: ['Name']
    key plant_no as PlantNo,
    name as Name
}
