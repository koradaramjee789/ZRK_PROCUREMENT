@EndUserText.label: 'Partial PR to PC'
@Metadata.allowExtensions: true
define root abstract entity ZRK_A_PartialPrToPCHead
  // with parameters parameter_name : parameter_type
{
  key ObjectId : zrk_object_id ;
  Buyer : zrk_buyer_id;
  
  _Items : composition [0..*] of ZRK_A_PartialPrToPC ;
}
