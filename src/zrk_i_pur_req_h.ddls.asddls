@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data definition for pur requisition'
@Metadata.allowExtensions: true
define root view entity ZRK_I_PUR_REQ_H 
as select from zrk_t_pur_req_h as PRHead
composition [0..*] of ZRK_I_PUR_REQ_I as _PRItem
association [1..1]  to ZRK_I_BUYER as _BuyerF4 on $projection.Buyer = _BuyerF4.BuyerId
{
   
    key PRHead.object_id as ObjectId,
    PRHead.description as Description,
    PRHead.stat_code as StatCode,
    PRHead.buyer as Buyer,
    PRHead.created_by as CreatedBy,
    PRHead.created_at as CreatedAt,
    PRHead.last_changed_by as LastChangedBy,
    PRHead.last_changed_at as LastChangedAt,
    _BuyerF4.Name as BuyerName,
 
    
   _PRItem,
   _BuyerF4
}
