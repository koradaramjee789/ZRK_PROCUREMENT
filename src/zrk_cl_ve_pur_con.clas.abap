CLASS zrk_cl_ve_pur_con DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
protected section.
private section.
ENDCLASS.



CLASS ZRK_CL_VE_PUR_CON IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lt_original_data TYPE STANDARD TABLE OF zrk_i_pur_con_ud WITH KEY ConUuid.

    lt_original_data = CORRESPONDING #( it_original_data ).
*    DATA(lt_original_data2) =  it_original_data .
    SELECT a~conuuid FROM zrk_dt_pur_con_u AS a
    INNER JOIN @lt_original_data AS b ON a~conuuid = b~conuuid
    INTO TABLE @DATA(lt_draft_data).
    IF sy-subrc = 0.
      SORT lt_draft_data BY conuuid.
    ENDIF.

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      <fs_original_data>-DraftFlag =
          COND #( WHEN line_exists( lt_draft_data[ conuuid = <fs_original_data>-ConUuid ] )
                  THEN abap_true
                  ELSE abap_false ).
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
