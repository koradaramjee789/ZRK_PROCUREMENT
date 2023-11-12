@EndUserText.label: 'Abs. entity for converting PR into PC'
define abstract entity ZRK_A_ActionParam_PR_To_PC
{
  supplier     : zrk_sup_no;
  buyer        : zrk_buyer_id;
  Company_code : zrk_company_code;
  valid_from   : /dmo/begin_date;
  valid_to     : /dmo/end_date;

}
