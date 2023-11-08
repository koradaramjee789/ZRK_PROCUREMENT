@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Project for unmanaged draft'
@Metadata.allowExtensions: true
@UI.presentationVariant: [{
    sortOrder: [{
        by: 'ObjectId',
        direction: #DESC
    }]
 }]
@ObjectModel.semanticKey:  [ 'ObjectId' ]
define root view entity ZRK_C_PUR_CON_UD
  provider contract transactional_query
  as projection on ZRK_I_PUR_CON_UD
{
  key ConUuid,
      @Consumption.semanticObject: 'PurCon'
      @ObjectModel.text.element: ['Description']
      ObjectId,
      Description,
      //  @ObjectModel.text.element: ['BuyerName']
      Buyer,
      //  @UI.hidden: true
      BuyerF4.Name     as BuyerName,

      @ObjectModel.text.element: ['BuyerNameDisp']
      BuyerDisp,

      BuyerF4.Name     as BuyerNameDisp,

      @ObjectModel.text.element: ['SupplierName']
      Supplier,
      @UI.hidden: true
      Supplier_f4.Name as SupplierName,
      SupConId,
      @ObjectModel.text.element: ['sent_via_text']
      SendVia,
      @UI.hidden: true
      sent_via_text,
      CompCode,
      @ObjectModel.text.element: ['Status']
      StatCode,
      @UI.hidden: true
      Status,
      @Semantics.amount.currencyCode: 'currency'
      TargetValue,
      @Semantics.currencyCode: true
      currency,
      FisclYear,
      ValidFrom,
      ValidTo,
      VersionNo,
      ReleasedAtLeastOnce,
      DraftFlag,
      urgent_flag,
      urgent_comments,
      AdhocUrgent,
      @ObjectModel.virtualElementCalculatedBy:'ABAP:ZRK_CL_CVE_PUR_CON'
      virtual HideActSendApprovalFlag : abap_boolean,      
      @ObjectModel.virtualElementCalculatedBy:'ABAP:ZRK_CL_CVE_PUR_CON'
      virtual HideActEditFlag : abap_boolean,
      @ObjectModel.virtualElementCalculatedBy:'ABAP:ZRK_CL_CVE_PUR_CON'
      virtual HideActForwardFlag : abap_boolean,      
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LoclLastChangedAt,

      _PurConItem : redirected to composition child ZRK_C_PUR_CON_I,
      Attachments : redirected to composition child ZRK_C_PUR_CON_ATT,

      BuyerF4,
      Supplier_f4,
      SendViaF4,
      StatusF4

}
