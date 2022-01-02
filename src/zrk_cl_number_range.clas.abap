CLASS zrk_cl_number_range DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrk_cl_number_range IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA : nr_interval   TYPE cl_numberrange_intervals=>nr_interval.

         nr_interval = VALUE #( ( subobject = ''
                                  nrrangenr = '01'
                                  fromnumber  = '10000000'
                                  tonumber    = '99999999'
                                  procind     = 'I' )  ).

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
*  CATCH cx_nr_object_not_found.
*  CATCH cx_number_ranges.

  ENDMETHOD.
ENDCLASS.
