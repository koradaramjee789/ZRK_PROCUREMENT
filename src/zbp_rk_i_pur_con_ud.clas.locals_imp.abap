CLASS lhc_PurCon DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR PurCon RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PurCon RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE PurCon.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE PurCon.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE PurCon.

    METHODS read FOR READ
      IMPORTING keys FOR READ PurCon RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK PurCon.
    METHODS set_pc_num FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurCon~set_pc_num.

ENDCLASS.

CLASS lhc_PurCon IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

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

  METHOD set_pc_num.

  READ ENTITIES OF zrk_i_pur_con_ud
    IN LOCAL MODE
    ENTITY PurCon
    FIELDS ( ObjectId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_con).

    lt_con[ 1 ]-ObjectId = 'PCD01'.

    MODIFY ENTITIES OF zrk_i_pur_con_ud
    IN LOCAL MODE
    ENTITY PurCon
    UPDATE FIELDS ( ObjectId ValidFrom ValidTo FisclYear Buyer )
    WITH VALUE #( FOR <fs_con> IN lt_con ( %tky = <fs_con>-%tky
                                             ObjectId = <fs_con>-ObjectId
                                             ValidFrom = cl_abap_context_info=>get_system_date( )
                                             ValidTo = cl_abap_context_info=>get_system_date(  ) + 364
                                             Buyer = sy-uname
                                             FisclYear = '2022' ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZRK_I_PUR_CON_UD DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZRK_I_PUR_CON_UD IMPLEMENTATION.

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
