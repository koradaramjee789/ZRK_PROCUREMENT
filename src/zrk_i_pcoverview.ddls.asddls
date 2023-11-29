@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DDL for PC Overview'
define root view entity ZRK_I_PCOverview
  as select from ZRK_R_PC_OVERVIEW
  association of one to many ZRK_I_PCOverview as _ParentObject on $projection.ParentObjectId = _ParentObject.object_id
{
  key concat( object_id, concat( ' / ', ItemNo ) ) as ObjectItemNo,
      object_id,
      ItemNo,
      description,
      buyer,
      supplier,
      stat_code,
      target_value,
      currency,
      quantity,
      unit,
      price,
      ParentObjectId,
      _ParentObject

}
