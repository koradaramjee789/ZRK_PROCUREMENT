@AbapCatalog.sqlViewName: 'ZRK_V_BUYER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD for buyer'
@Metadata.allowExtensions: true
@ObjectModel: {
    representativeKey: 'BuyerId'
}
define view ZRK_I_BUYER as select from zrk_md_buyer {

    @UI.facet: [{
        id: 'id1',
        purpose: #QUICK_VIEW,
        label: 'Buyer - Quickview',
        targetQualifier: 'data',
        type: #FIELDGROUP_REFERENCE
    }]

    
    @ObjectModel.text.element: ['Name']
//    @Semantics.contact.type: #PERSON
    key buyer_id as BuyerId,
    @UI.fieldGroup: [{ qualifier: 'data', position: 10 }]
    @Semantics.name.fullName: true
    name as Name,
    @UI.fieldGroup: [{ qualifier: 'data', position: 20 }]
    @Semantics.eMail.address 
    email_id as EmailId
}
