@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data definition for PR Item'
@Metadata.allowExtensions: true
define view entity ZRK_I_PUR_REQ_I 
as select from zrk_t_pur_req_i as PRItem
association to parent ZRK_I_PUR_REQ_H as _PRHead  
    on $projection.ObjectId = _PRHead.ObjectId
    
association to ZRK_I_PLANT as _plant on $projection.Plant = _plant.PlantNo

association to ZRK_I_PARTS as _partsF4 on $projection.PartNo = _partsF4.PartNo

association to ZRK_I_SUPPLIER as _SupplierF4 on $projection.Supplier = _SupplierF4.SupNo
    
{
   
    key PRItem.object_id as ObjectId,
    key PRItem.item_no as ItemNo,
    PRItem.description as Description,
    PRItem.part_no as PartNo,
    PRItem.unit as Unit,
    PRItem.comm_code as CommCode,
    PRItem.plant as Plant,
    PRItem.supplier as Supplier,
        @Semantics.quantity.unitOfMeasure: 'Unit'
    PRItem.quantity as Quantity,
      @Semantics.amount.currencyCode: 'Currency'
    PRItem.price as Price,
    PRItem.currency as Currency,
    PRItem.created_by as CreatedBy,
    PRItem.created_at as CreatedAt,
    PRItem.last_changed_by as LastChangedBy,
    PRItem.last_changed_at as LastChangedAt,
    
    _PRHead,
    _plant,
    _partsF4,
    _SupplierF4
}
