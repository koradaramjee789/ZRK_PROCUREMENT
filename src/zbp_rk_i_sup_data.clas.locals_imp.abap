CLASS lhc_ZRK_I_SUP_DATA DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zrk_i_sup_data RESULT result.

ENDCLASS.

CLASS lhc_ZRK_I_SUP_DATA IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
