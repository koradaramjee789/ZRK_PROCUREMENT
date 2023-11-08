@EndUserText.label: 'Analytical projection view for PC'
@AccessControl.authorizationCheck: #NOT_ALLOWED

@Metadata.allowExtensions: true
define view entity zrk_c_ana_pur_con
  //provider contract analytical_query
  as projection on zrk_i_ana_pur_con
{
  key ConUuid,
  //    @Consumption.semanticObject : 'zrkv4purcon'
  //    @Consumption.semanticObjectMapping: {
  //        element: 'PurCon',
  //        additionalBinding: [{
  //            localElement: 'ObjectId',
  //            element: 'ObjectId'
  //        }]
  //    }
  @UI.lineItem: [{ position: 10 ,
                   type: #FOR_INTENT_BASED_NAVIGATION   ,
                   semanticObject: 'zrkv4purcon' ,
                   semanticObjectAction: 'display'
                   }]
   @AnalyticsDetails.query.axis: #ROWS
  ObjectId,
  @UI.lineItem: [{position: 20 }]
  Description,
  @UI.lineItem: [{position: 30 }]
  Buyer,
  @UI.lineItem: [{position: 40 }]
  Supplier,
  SupConId,
  SendVia,
  @UI.lineItem: [{position: 50 }]
  CompCode,
  @UI.lineItem: [{position: 60 }]
  StatCode,
  FisclYear,
  ValidFrom,
  ValidTo,
  @Semantics.amount.currencyCode: 'Currency'
  @Aggregation.default: #SUM
  @UI.lineItem: [{position: 70 }]
  TargetValue,
  Currency,

  @Semantics.amount.currencyCode: 'EurCurrency'
 @Aggregation.default: #SUM
  EurTargetValue,
  EurCurrency

}
