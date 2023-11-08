@EndUserText.label: 'Abstract Entity for renewing the document'
@Metadata.allowExtensions: true
define abstract entity ZRK_A_RENEW_DOC
  //  with parameters parameter_name : parameter_type
{
  @UI.hidden        : true
  CompCode     : zrk_company_code;
//  @Consumption.valueHelpDefinition: [{
//              entity       : {
//                name       : 'ZRK_CE_Renewal_Codes',
//                element    : 'renewal_code'
//              },
//              useForValidation: true,
//              label        : 'Select currency from Dailog',
//              additionalBinding: [ { localElement: 'CompCode',
//  //                                    parameter: 'p_comp_code',
//                                    element      : 'CompCode',
//                                    usage: #FILTER_AND_RESULT }
//                ]  } ]
  @EndUserText.label: 'Code'
  renewal_code : abap.char( 3 );

}
