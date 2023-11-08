@EndUserText.label: 'Partial PR to PC'
define abstract entity ZRK_A_PartialPrToPC
  {
  key item_no   : zrk_item_no;
      part_no   : zrk_part_no;
      comm_code : zrk_category_id;
      plant     : zrk_plant_no;
      supplier  : zrk_sup_no;
      
      _Parent : association to parent ZRK_A_PartialPrToPCHead ;
}
