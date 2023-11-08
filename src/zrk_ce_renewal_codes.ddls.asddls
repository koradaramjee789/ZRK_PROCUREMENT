@EndUserText.label: 'Custom Entity to get renewal codes'
@ObjectModel.query.implementedBy: 'ABAP:ZRK_CL_CE_RENEWAL_CODES'
define custom entity ZRK_CE_Renewal_Codes
  // with parameters p_comp_code : zrk_company_code
{
      @UI.hidden        : true
  key CompCode          : zrk_company_code;
      @EndUserText.label: 'Code'
  key renewal_code      : abap.char( 3 );
      @EndUserText.label: 'Description'
      renewal_code_desc : abap.char(20);

}
