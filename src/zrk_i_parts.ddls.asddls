@AbapCatalog.sqlViewName: 'ZRK_V_PARTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data definition for Parts'

define view ZRK_I_PARTS as select from zrk_md_parts {
@ObjectModel.text.element: ['Description']
@UI.hidden: true
    key part_no as PartNo,
    description as Description,
    @Consumption.valueHelpDefinition: [{ entity: {
        name: 'zrk_i_categories',
        element: 'CategoryId'
    } }]
    category_id as CategoryId,
    unit as Unit
}
