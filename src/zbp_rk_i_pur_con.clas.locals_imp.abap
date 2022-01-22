CLASS lhc_PurCon DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

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
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR PurCon RESULT result.
    METHODS defaultforcreate FOR READ
      IMPORTING keys FOR FUNCTION purcon~defaultforcreate RESULT result.

ENDCLASS.

CLASS lhc_PurCon IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA ls_pur_con TYPE zrk_t_pur_con.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

      DATA(lo_pur_con) = NEW zrk_cl_mng_pur_con(  <fs_entity>-ConUuid ).

      ls_pur_con-client = sy-mandt.
      ls_pur_con-con_uuid = COND #( WHEN <fs_entity>-ConUuid IS NOT INITIAL
                                    THEN <fs_entity>-ConUuid
                                    ELSE cl_system_uuid=>create_uuid_x16_static(  ) )  .
      ls_pur_con-object_id = <fs_entity>-ObjectId .
      ls_pur_con-description = <fs_entity>-Description .
      ls_pur_con-buyer = <fs_entity>-Buyer .
      ls_pur_con-supplier = <fs_entity>-Supplier .
      ls_pur_con-sup_con_id = <fs_entity>-SupConId .
      ls_pur_con-comp_code = <fs_entity>-CompCode .
      ls_pur_con-stat_code = <fs_entity>-StatCode .
      ls_pur_con-valid_from = <fs_entity>-Validfrom .
      ls_pur_con-valid_to = <fs_entity>-ValidTo .
      ls_pur_con-created_at = <fs_entity>-CreatedAt .
      ls_pur_con-created_by = <fs_entity>-CreatedBy .

      lo_pur_con->create( is_pur_con = ls_pur_con ).

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

      DATA(lo_pur_con) = NEW zrk_cl_mng_pur_con(  <fs_entity>-ConUuid ).
      DATA(ls_pur_con) = lo_pur_con->get( ).

      ls_pur_con-client = sy-mandt.
      ls_pur_con-con_uuid = COND #( WHEN <fs_entity>-%control-ConUuid EQ '01'
                                        THEN <fs_entity>-ConUuid
                                        ELSE ls_pur_con-con_uuid )  .
      ls_pur_con-object_id = COND #( WHEN <fs_entity>-%control-ObjectId EQ '01'
                                     THEN <fs_entity>-ObjectId
                                     ELSE ls_pur_con-object_id ) .
      ls_pur_con-description = COND #( WHEN <fs_entity>-%control-Description EQ '01'
                                        THEN <fs_entity>-Description
                                        ELSE ls_pur_con-description ) .
      ls_pur_con-buyer = <fs_entity>-Buyer .
      ls_pur_con-supplier = <fs_entity>-Supplier .
      ls_pur_con-sup_con_id = <fs_entity>-SupConId .
      ls_pur_con-comp_code = COND #( WHEN <fs_entity>-%control-CompCode EQ '01'
                                        THEN <fs_entity>-CompCode
                                        ELSE ls_pur_con-comp_code ) .
      ls_pur_con-stat_code = <fs_entity>-StatCode .
      ls_pur_con-valid_from = COND #( WHEN <fs_entity>-%control-ValidFrom EQ '01'
                                      THEN <fs_entity>-Validfrom
                                      ELSE ls_pur_con-valid_from ).
      ls_pur_con-valid_to = COND #( WHEN <fs_entity>-%control-ValidTo EQ '01'
                                      THEN <fs_entity>-ValidTo
                                      ELSE ls_pur_con-valid_To ).
      ls_pur_con-created_at = <fs_entity>-CreatedAt .
      ls_pur_con-created_by = COND #( WHEN <fs_entity>-%control-CreatedBy EQ '01'
                                      THEN <fs_entity>-CreatedBy
                                      ELSE ls_pur_con-created_by ).

      lo_pur_con->modify( is_pur_con = ls_pur_con ).

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).

      DATA(lo_pur_con) = NEW zrk_cl_mng_pur_con(  <fs_key>-ConUuid ).
      lo_pur_con->delete( ).
    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

*  METHOD get_instance_features.
*
*
**    READ ENTITIES OF Zrk_I_Pur_Con IN LOCAL MODE
**        ENTITY PurCon
**        ALL FIELDS WITH CORRESPONDING #( keys )
**        RESULT DATA(lt_con)
**        FAILED DATA(lt_failed).
**
**    LOOP AT lt_con ASSIGNING FIELD-SYMBOL(<fs_con>).
**
**        APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_con_result>).
**
**        <fs_con_result>-%tky = <fs_con>-%tky.
**        <fs_con_result>-%field-ValidFrom = sy-datum.
**        <fs_con_result>-%field-Validto = <fs_con_result>-%field-ValidFrom + 365.
**
**
**    ENDLOOP.
*
*  ENDMETHOD.

  METHOD DefaultForCreate.

    DATA : lt_pur_con TYPE TABLE FOR READ RESULT zrk_i_pur_con\\purcon .

    APPEND INITIAL LINE TO lt_pur_con ASSIGNING FIELD-SYMBOL(<fs_new_con>).

    <fs_new_con>-conuuid = cl_system_uuid=>create_uuid_x16_static( ).

    <fs_new_con>-Description = 'Defaulted from backend'.

*    <fs_new_con>-ValidFrom = cl_abap_context_info=>get_system_date( ).
*
*    <fs_new_con>-ValidTo = <fs_new_con>-ValidFrom + 364.

    <fs_new_con>-Buyer = sy-uname.

    <fs_new_con>-CreatedBy = sy-uname.
    "
    <fs_new_con>-CompCode =
        zrk_cl_mng_pur_con=>get_defaults_for_create(  )-comp_code.

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
    <fs_new_con>-FiscalYear = lv_date+0(4).

    result = VALUE #( FOR <fs_rec_m> IN lt_pur_con
                        ( %cid = keys[ 1 ]-%cid
                          %param = <fs_rec_m> )
                        ) .

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZRK_I_PUR_CON DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_ZRK_I_PUR_CON IMPLEMENTATION.

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

  METHOD adjust_numbers.


  ENDMETHOD.

ENDCLASS.
