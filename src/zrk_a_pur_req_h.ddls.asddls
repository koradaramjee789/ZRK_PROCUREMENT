@EndUserText.label: 'Abstract entity for Copy requisition'
define abstract entity zrk_a_pur_req_h
  //  with parameters parameter_name : parameter_type
  
{

  
  description : zrk_description;
  @Consumption.valueHelpDefinition: [{
    entity    : {
        name  : 'ZRK_I_BUYER',
        element: 'BuyerId'
    }
  }]
  buyer       : zrk_buyer_id;

}
