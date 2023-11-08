CLASS lhc_ApprDoc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ApprDoc RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE ApprDoc.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE ApprDoc.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE ApprDoc.

    METHODS read FOR READ
      IMPORTING keys FOR READ ApprDoc RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK ApprDoc.

ENDCLASS.

CLASS lhc_ApprDoc IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZRK_CE_APPR_DOCS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZRK_CE_APPR_DOCS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
