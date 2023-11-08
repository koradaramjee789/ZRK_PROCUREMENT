CLASS zrk_cl_ce_renewal_codes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES : if_rap_query_provider ,
      if_rap_query_request.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES t_business_data TYPE TABLE OF ZRK_CE_Renewal_Codes.
ENDCLASS.



CLASS ZRK_CL_CE_RENEWAL_CODES IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA business_data TYPE t_business_data.
    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).
    DATA count TYPE int8.

***filter
    DATA(lv_sql_filter) = io_request->get_filter( )->get_as_sql_string( ).
    TRY.
        DATA(lt_filter) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.
        "handle exception
    ENDTRY.

    APPEND INITIAL LINE TO business_data ASSIGNING FIELD-SYMBOL(<fs_business_data>).
    <fs_business_data>-CompCode = 'CC28'.
    <fs_business_data>-renewal_code = 'RN1'.
    <fs_business_data>-renewal_code_desc = 'Preapproved'.
    APPEND INITIAL LINE TO business_data ASSIGNING <fs_business_data>.
    <fs_business_data>-CompCode = 'CC29'.
    <fs_business_data>-renewal_code = 'RN2'.
    <fs_business_data>-renewal_code_desc = 'Tobe Approved'.

    LOOP AT lt_filter ASSIGNING FIELD-SYMBOL(<fs_filter>).
      CASE <fs_filter>-name.
        WHEN 'COMPCODE'.
          DELETE business_data WHERE CompCode NOT IN <fs_filter>-range.
      ENDCASE.
    ENDLOOP.

    IF io_request->is_total_numb_of_rec_requested(  ).
      io_response->set_total_number_of_records( 2 ).
    ENDIF.

    IF io_request->is_data_requested(  ).
      io_response->set_data( business_data ).
    ENDIF.

  ENDMETHOD.


  METHOD if_rap_query_request~get_filter.

  ENDMETHOD.
ENDCLASS.
