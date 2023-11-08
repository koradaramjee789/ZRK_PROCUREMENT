CLASS zrk_cl_cve_pur_con DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
protected section.
private section.
ENDCLASS.



CLASS ZRK_CL_CVE_PUR_CON IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lt_original_data TYPE STANDARD TABLE OF zrk_c_pur_con_ud WITH KEY ConUuid.

    lt_original_data = CORRESPONDING #( it_original_data ).
**    DATA(lt_original_data2) =  it_original_data .
*    SELECT a~conuuid FROM zrk_dt_pur_con_u AS a
*    INNER JOIN @lt_original_data AS b ON a~conuuid = b~conuuid
*    " TODO: variable is assigned but never used (ABAP cleaner)
*    INTO TABLE @DATA(lt_draft_data).
*    IF sy-subrc = 0.
*      SORT lt_draft_data BY conuuid.
*    ENDIF.

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      <fs_original_data>-HideActSendApprovalFlag = COND #( WHEN <fs_original_data>-StatCode = 'AWAP'
                                                           THEN abap_true
                                                           ELSE abap_false ).
      <fs_original_data>-HideActEditFlag = COND #( WHEN <fs_original_data>-StatCode = 'AWAP'
                                                           THEN abap_true
                                                           ELSE abap_false ).
      <fs_original_data>-HideActForwardFlag = COND #( WHEN <fs_original_data>-StatCode = 'AWAP'
                                                           THEN abap_true
                                                           ELSE abap_false ).
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
