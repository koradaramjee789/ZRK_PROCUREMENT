@EndUserText.label: 'Abs. entity for converting PR into PC'
define abstract entity ZRK_A_ActionParam_PR_To_PC
{

  description  : /dmo/description;
  @Consumption.valueHelpDefinition: [{
      entity   : {
          name : 'ZRK_I_BUYER',
          element: 'BuyerId'
      },
      label    : 'Select Buyer'
  }]
  buyer        : zrk_buyer_id;
  @Consumption.valueHelpDefinition: [{
  entity       : {
      name: 'ZRK_I_COMP_CODE',
      element  : 'CompCode'
  },
  label        : 'Select Company Code'
  }]
  Company_code : zrk_company_code;
  valid_from   : /dmo/begin_date;
  valid_to     : /dmo/end_date;
  @Consumption.valueHelpDefinition: [{
    entity     : {
                name       : 'ZRK_I_SUP_CON',
                element    : 'SupConId'
    },
    label      : 'Select Supplier'
  }]
  supplier     : zrk_sup_no;

}
