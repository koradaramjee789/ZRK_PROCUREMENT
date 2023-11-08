@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZRK_I_Country'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZRK_I_Country as select from I_CountryText
{
    key Country,
    Language,
    CountryName,
    NationalityName,
    NationalityLongName,
    CountryShortName,
    /* Associations */
    _Country,
    _Language
}
where Language = $session.system_language
