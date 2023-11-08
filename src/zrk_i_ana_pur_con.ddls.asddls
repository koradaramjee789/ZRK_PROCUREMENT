@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Analytical view for purchase contracts'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.dataCategory: #CUBE
define view entity zrk_i_ana_pur_con as select from zrk_t_pur_con 
association [0..1] to ZRK_I_SUPPLIER as _Supplier on _Supplier.SupNo = $projection.Supplier

{
    key con_uuid as ConUuid,
    object_id as ObjectId,
    description as Description,
    buyer as Buyer,
    supplier as Supplier,
    sup_con_id as SupConId,
    send_via as SendVia,
    comp_code as CompCode,
    stat_code as StatCode,
    fiscl_year as FisclYear,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    @Semantics.amount.currencyCode: 'Currency'
    target_value as TargetValue,
    currency as Currency,
    @Semantics.amount.currencyCode: 'EurCurrency'
    currency_conversion(amount => target_value , source_currency => currency , target_currency => cast('EUR' as abap.cuky( 5 ) ), exchange_rate_date => $session.system_date ) as EurTargetValue,
    cast('EUR' as abap.cuky( 5 ) ) as EurCurrency,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    locl_last_changed_at as LoclLastChangedAt,
    _Supplier
}

//where currency = 'USD'
