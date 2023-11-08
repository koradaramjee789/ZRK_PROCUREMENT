@AbapCatalog.sqlViewName: 'ZRK_V_CATEG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'data definition for categories'

define view zrk_i_categories as select from zrk_md_category {
@ObjectModel.text.element: ['Description']
@UI.hidden: true
    key category_id as CategoryId,
    description as Description
}
