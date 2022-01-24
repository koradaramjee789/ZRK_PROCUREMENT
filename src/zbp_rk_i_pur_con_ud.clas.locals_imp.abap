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
    METHODS Forward FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~Forward RESULT result.

ENDCLASS.

CLASS lhc_PurCon IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

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

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).

      DATA(lo_pur_con) = NEW zrk_cl_mng_pur_con(  <fs_key>-ConUuid ).
      DATA(ls_pur_con) = lo_pur_con->get( ).

      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
      <fs_result>-%tky = <fs_key>-%tky.
      <fs_result> = CORRESPONDING #( ls_pur_con ).
    ENDLOOP.

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

*    lt_con[ 1 ]-ObjectId = 'PCD01'.

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

  METHOD Forward.


    READ TABLE keys ASSIGNING FIELD-SYMBOL(<fs_key>) INDEX 1.
    IF sy-subrc EQ 0.
      DATA(lv_new_buyer) = <fs_key>-%param-Buyer.
    ENDIF.

    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
    ENTITY PurCon
    FIELDS ( Buyer )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_buyer).

    MODIFY TABLE lt_buyer FROM VALUE #( Buyer = lv_new_buyer ).

    MODIFY ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
    ENTITY PurCon
    UPDATE FIELDS ( Buyer )
    WITH VALUE #( FOR <fs_rec> IN lt_buyer ( %tky = <fs_rec>-%tky
                                             %is_draft = '01'
                                             Buyer = <fs_rec>-Buyer ) ).

    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
    ENTITY PurCon
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_buyer_updated).

    result = VALUE #( FOR <fs_rec> IN lt_buyer ( %tky = <fs_rec>-%tky
                                             %param = <fs_rec> ) ).


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
