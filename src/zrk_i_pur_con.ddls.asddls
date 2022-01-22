@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ID for purchase contract'
define root view entity Zrk_I_Pur_Con as select from zrk_t_pur_con
 
{
    key con_uuid as ConUuid,
    object_id as ObjectId,
    description as Description,
    buyer as Buyer,
    supplier as Supplier,
    sup_con_id as SupConId,
    comp_code as CompCode,
    stat_code as StatCode,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    fiscl_year as FiscalYear,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    locl_last_changed_at as LoclLastChangedAt
    
}
