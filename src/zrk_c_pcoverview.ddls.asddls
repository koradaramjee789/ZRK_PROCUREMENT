@EndUserText.label: 'Projection for PC Overview'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@OData.hierarchy.recursiveHierarchy:[{ entity.name: 'ZRK_I_HN_PCOverview' }]
define root view entity ZRK_C_PCOverview
  provider contract transactional_query
  as projection on ZRK_I_PCOverview
  association of one to many ZRK_C_PCOverview as _ParentObject on $projection.ParentObjectId = _ParentObject.object_id
{
  key ObjectItemNo,
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
      /* Associations */
      _ParentObject
}
