@EndUserText.label: 'Abstract emtity for conditions'
define abstract entity zrk_a_cond 
//  with parameters parameter_name : parameter_type 
  {
    cond_type            : zrk_cond_type;
  valid_from           : zrk_valid_from;
  valid_to             : zrk_valid_to;
  @Semantics.amount.currencyCode : 'CURRENCY'
  price                : zrk_price;
    currency             : zrk_currency_code;
}
