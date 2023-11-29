@EndUserText.label: 'Forward to buyer'
@Metadata.allowExtensions: true
define abstract entity ZRK_I_FWD_BUYER

{
  @Consumption.defaultValue: 'RAMJEE'
  ToBeBuyer : zrk_buyer_id;
}
