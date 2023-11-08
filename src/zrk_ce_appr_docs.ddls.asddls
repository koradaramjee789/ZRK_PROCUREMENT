@EndUserText.label: 'Approval documents'
@ObjectModel.query.implementedBy: 'ABAP:ZRK_CL_CE_APPR_DOCS'
define root custom entity ZRK_CE_APPR_DOCS
  // with parameters parameter_name : parameter_type
{

      @UI.facet   : [{ position: 10, purpose: #STANDARD , type:  #IDENTIFICATION_REFERENCE}
      //              { position: 20, purpose: #STANDARD , type:  #LINEITEM_REFERENCE , targetElement: '_Items'}
                  ]
      @UI.identification: [{ position: 10 }]
      @UI.lineItem: [{ position: 10 }]
  key DocType     : zrk_doc_type;
      @UI.identification: [{ position: 20 }]
      @UI.lineItem: [{ position: 20 }]
  key ObjectId    : zrk_object_id;
      @UI.identification: [{ position: 30 }]
      @UI.lineItem: [{ position: 30 }]
      Buyer       : zrk_buyer_id;
      @UI.identification: [{ position: 40 }]
      @UI.lineItem: [{ position: 40 }]

      Description : zrk_description;
      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 50 }]
      @Semantics.amount.currencyCode: 'Currency'
      TargetValue : zrk_target_value;
      @UI.lineItem: [{ hidden: true }]
      @Semantics.currencyCode: true
      Currency    : zrk_currency_code;
}
