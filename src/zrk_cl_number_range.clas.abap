CLASS zrk_cl_number_range DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZRK_CL_NUMBER_RANGE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*
*  DATA : nr_interval   TYPE cl_numberrange_intervals=>nr_interval.
*
*         nr_interval = VALUE #( ( subobject = ''
*                                  nrrangenr = '01'
*                                  fromnumber  = '10000000'
*                                  tonumber    = '99999999'
*                                  procind     = 'I' )  ).
*
*  cl_numberrange_intervals=>create(
*    EXPORTING
*      interval  = nr_interval
*      object    = 'ZRK_NR_PR'
**      subobject =
**      option    =
**    IMPORTING
**      error     =
**      error_inf =
**      error_iv  =
**      warning   =
*  ).
**  CATCH cx_nr_object_not_found.
**  CATCH cx_number_ranges.

  DATA : nr_interval   TYPE cl_numberrange_intervals=>nr_interval.

         nr_interval = VALUE #( ( subobject = ''
                                  nrrangenr = '01'
                                  fromnumber  = '00000001'
                                  tonumber    = '99999999'
                                  procind     = 'I' )  ).
try.
  cl_numberrange_intervals=>create(
    EXPORTING
      interval  = nr_interval
      object    = 'ZRK_NR_PR'
*      subobject =
*      option    =
*    IMPORTING
*      error     =
*      error_inf =
*      error_iv  =
*      warning   =
  ).
  CATCH cx_nr_object_not_found.
  CATCH cx_number_ranges.
endtry.
*cl_numberrange_intervals=>update(
*  EXPORTING
*    interval  = nr_interval
*    object    = 'ZRK_NR_PC'
**    subobject =
**    option    =
**  IMPORTING
**    error     =
**    error_inf =
**    error_iv  =
**    warning   =
*).
**CATCH cx_nr_object_not_found.
**CATCH cx_number_ranges.

*cl_numberrange_intervals=>delete(
*  EXPORTING
*    interval  = nr_interval
*    object    = 'ZRK_NR_PC'
**    subobject =
**    option    =
**  IMPORTING
**    error     =
**    error_inf =
**    error_iv  =
**    warning   =
*).
**CATCH cx_nr_object_not_found.
**CATCH cx_number_ranges.

  ENDMETHOD.
ENDCLASS.
