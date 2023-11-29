@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PC Overview'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZRK_R_PC_OVERVIEW
  as select from zrk_t_pur_con
{
  key con_uuid                       as uuid,
      object_id,
      cast ( '' as zrk_item_no )     as ItemNo,
      description,
      buyer,
      supplier,
      stat_code,
      @Semantics.amount.currencyCode: 'currency'
      target_value,
      currency,
      @Semantics.quantity.unitOfMeasure: 'unit'
      cast ( 0.00  as zrk_quantity ) as quantity,
      cast ( ''   as zrk_unit )      as unit,
      @Semantics.amount.currencyCode: 'currency'
      cast ( 0.00 as zrk_price )     as price,
      //      cast ('' as sysuuid_x16 ) as parent_uuid
      cast ( '' as zrk_object_id )   as ParentObjectId
}
union

select from ZRK_I_PUR_CON_I
{
  key ConItemUuid                        as uuid,
      _PurCon.ObjectId                   as object_id,
      ItemNo,
      Description,
      ''                                 as buyer,
      ''                                 as supplier,
      ''                                 as stat_code,
      cast ( 0.00  as zrk_target_value ) as target_value,
      Currency,
      Quantity,
      Unit,
      Price,
      _PurCon.ObjectId                   as ParentObjectId

}
