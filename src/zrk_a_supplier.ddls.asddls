@EndUserText.label: 'Abstract entity for Supplier'
@Metadata.allowExtensions: true
define root abstract entity zrk_a_supplier 
 {
    @UI.defaultValue : #( 'ELEMENT_OF_REFERENCED_ENTITY: Supplier')
    ToBesupplier : zrk_sup_no;
    
}
