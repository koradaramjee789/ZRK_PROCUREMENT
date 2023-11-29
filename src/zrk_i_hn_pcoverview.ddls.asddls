define hierarchy ZRK_I_HN_PCOverview
  as parent child hierarchy(
    source ZRK_I_PCOverview
    child to parent association _ParentObject
    start where
      ParentObjectId is initial
    siblings order by
      ItemNo
  )
{
  key  ObjectItemNo,
       ParentObjectId
}
