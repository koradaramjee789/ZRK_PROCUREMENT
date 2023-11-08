@AbapCatalog.sqlViewName: 'ZRK_V_SUPPL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DD For supplier'
@Search.searchable: true
@Metadata.allowExtensions: true
define view ZRK_I_SUPPLIER as select from zrk_md_supplier {
@ObjectModel.text.element: ['Name']
//@UI.hidden: true
    key sup_no as SupNo,
    @Search.defaultSearchElement: true
    name as Name
}

