CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Header.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Header.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Header.

    METHODS read FOR READ
      IMPORTING keys FOR READ Header RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Header.

    METHODS rba_Items FOR READ
      IMPORTING keys_rba FOR READ Header\_Items FULL result_requested RESULT result LINK association_links.

    METHODS cba_Items FOR MODIFY
      IMPORTING entities_cba FOR CREATE Header\_Items.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.


    DATA : lt_sal_ord TYPE TABLE OF zrk_t_sal_ord_h .

    lt_sal_ord = VALUE #( FOR <fs_entity> IN entities
                            (   client   = sy-mandt
                                object_id =   <fs_entity>-objectid
                                description =   <fs_entity>-description
                                buyer   =   <fs_entity>-buyer
                                stat_code   =   'OPEN'
                                created_by  =   <fs_entity>-createdby
                                created_at  =   <fs_entity>-createdat
                                last_changed_by =   <fs_entity>-lastchangedby
                                last_changed_at =   <fs_entity>-lastchangedat
                                local_last_changed_at   =   <fs_entity>-locallastchangedat
                             )
    ) .

    DATA(lo_sal_ord_mng) = zrk_cl_sal_ord_manage=>get_instance(  ).

    lo_sal_ord_mng->create(
      EXPORTING
        is_sal_ord   = VALUE #( lt_sal_ord[ 1 ] OPTIONAL )
      RECEIVING
        rv_object_id = DATA(lv_sal_ord_id)
    ).

    APPEND VALUE #( %cid = entities[ 1 ]-%cid objectid = lv_sal_ord_id ) TO mapped-header.



*    lo_sal_ord_mng->generate_sal_ord_id( ).

  ENDMETHOD.

  METHOD update.

    DATA : lt_sal_ord TYPE TABLE OF zrk_t_sal_ord_h .

    lt_sal_ord = VALUE #( FOR <fs_entity> IN entities
                            (    client   = sy-mandt
                                object_id =   <fs_entity>-objectid
                                description =   <fs_entity>-description
                                buyer   =   <fs_entity>-buyer
                                stat_code   =   <fs_entity>-statcode
                                created_by  =   <fs_entity>-createdby
                                created_at  =   <fs_entity>-createdat
                                last_changed_by =   <fs_entity>-lastchangedby
                                last_changed_at =   <fs_entity>-lastchangedat
                                local_last_changed_at   =   <fs_entity>-locallastchangedat
                             )
    ) .

    DATA(lo_sal_ord_mng) = zrk_cl_sal_ord_manage=>get_instance( ) .

    lo_sal_ord_mng->modify(
      EXPORTING
        is_sal_ord   = VALUE #( lt_sal_ord[ 1 ] OPTIONAL ) ).

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.


    IF 1 = 2 .

    ENDIF.

  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Items.

    IF 1 = 2.

    ENDIF.

  ENDMETHOD.

  METHOD cba_Items.

    DATA : ls_sal_ord_i TYPE zrk_t_sal_ord_i .

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<fs_entity_cba>).

      DATA(lo_sal_ord_mng) = zrk_cl_sal_ord_manage=>get_instance( iv_sal_ord_id = <fs_entity_cba>-objectid  ) .

      LOOP AT <fs_entity_cba>-%target ASSIGNING FIELD-SYMBOL(<fs_entity>).

        ls_sal_ord_i-client   = sy-mandt.
        ls_sal_ord_i-object_id =   <fs_entity_cba>-objectid.
        ls_sal_ord_i-item_no   =   <fs_entity>-ItemNo.
        ls_sal_ord_i-description =   <fs_entity>-description.
        ls_sal_ord_i-part_no     = <fs_entity>-PartNo.
        ls_sal_ord_i-plant     = <fs_entity>-Plant.
        ls_sal_ord_i-quantity     = <fs_entity>-Quantity.
        ls_sal_ord_i-price     = <fs_entity>-Price.
        ls_sal_ord_i-currency     = <fs_entity>-Currency.
        ls_sal_ord_i-unit     = <fs_entity>-unit.
        ls_sal_ord_i-created_by  =   <fs_entity>-createdby.
        ls_sal_ord_i-created_at  =   <fs_entity>-createdat.
        ls_sal_ord_i-last_changed_by =   <fs_entity>-lastchangedby.
        ls_sal_ord_i-last_changed_at =   <fs_entity>-lastchangedat.

        lo_sal_ord_mng->add_item( is_sal_ord_i = ls_sal_ord_i ).

      ENDLOOP.

    ENDLOOP.
*
*    lt_sal_ord_i = VALUE #( FOR <fs_entity_cba> IN entities_cba
*                              FOR <fs_entity> IN <fs_entity_cba>-%target
*                            (
**                                local_last_changed_at   =   <fs_entity>-locallastchangedat
*                             )
*    ) .



*    lo_sal_ord_mng->add_item( is_sal_ord_i = lt_sal_ord_i[ 1 ] ).

    APPEND INITIAL LINE TO mapped-items ASSIGNING FIELD-SYMBOL(<fs_item_map>).
    <fs_item_map>-%cid = <fs_entity>-%cid .
    <fs_item_map>-ObjectId = ls_sal_ord_i-object_id.
    <fs_item_map>-ItemNo = ls_sal_ord_i-Item_No.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_Items DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Items.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Items.

    METHODS read FOR READ
      IMPORTING keys FOR READ Items RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ Items\_Header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_Items IMPLEMENTATION.

  METHOD update.


    DATA : lt_sal_ord_i TYPE TABLE OF zrk_t_sal_ord_i .


    DATA(lo_sal_ord_mng) = zrk_cl_sal_ord_manage=>get_instance( ) .

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
      lo_sal_ord_mng->modify_item( is_sal_ord_i = VALUE #(
                                                          client   = sy-mandt
                                                          object_id =   <fs_entity>-objectid
                                                          item_no   =   <fs_entity>-ItemNo
                                                          description =   <fs_entity>-description
                                                          part_no     = <fs_entity>-PartNo
                                                          plant     = <fs_entity>-Plant
                                                          quantity     = <fs_entity>-Quantity
                                                          price     = <fs_entity>-Price
                                                          currency     = <fs_entity>-Currency
                                                          unit     = <fs_entity>-unit
                                                          created_by  =   <fs_entity>-createdby
                                                          created_at  =   <fs_entity>-createdat
                                                          last_changed_by =   <fs_entity>-lastchangedby
                                                          last_changed_at =   <fs_entity>-lastchangedat
                                                      ) ).
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Header.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZRK_I_SAL_ORD DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZRK_I_SAL_ORD IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.

    DATA(lo_sal_ord_mng) = zrk_cl_sal_ord_manage=>get_instance(  ).

    IF lo_sal_ord_mng->get_mode( ) = 'CREATE'.

      lo_sal_ord_mng->get(
        IMPORTING
          es_sal_ord = DATA(ls_sal_ord)
      ).

*    lo_sal_ord_mng->generate_sal_ord_id( ).

*    APPEND VALUE #( %cid = entities[ 1 ]-%cid objectid = lv_sal_ord_id ) TO mapped-header.

      APPEND VALUE #( "%pre-%pid               = 'MyPID'
                      %tmp-objectId      = ls_sal_ord-object_id
*                    %key-objectId           = ls_sal_ord-object_id
                      objectId     = lo_sal_ord_mng->generate_sal_ord_id( ) "ls_sal_ord-object_id
                    ) TO mapped-header.

*    mapped-header = VALUE #( ( CORRESPONDING #( ls_sal_ord  ) ) ).

    ENDIF.


*    lo_sal_ord_mng->generate_sal_ord_id( ).
*
*    lo_sal_ord_mng->get(
*      IMPORTING
*        es_sal_ord = DATA(ls_sal_ord)
*    ).
*




  ENDMETHOD.

  METHOD save.

    DATA(lo_sal_ord_mng) = zrk_cl_sal_ord_manage=>get_instance(  ).
    lo_sal_ord_mng->save( ).

    DATA(lv_sal_ord_id) = lo_sal_ord_mng->get_sal_ord_id( ).
    "fill reported structure to be displayed on the UI
    APPEND VALUE #( objectid = lv_sal_ord_id
                    %msg = new_message( id = 'ZRK_MESSAGES'
                                        number = COND #( WHEN lo_sal_ord_mng->get_mode(  ) = 'CREATE' THEN '006'
                                                         WHEN lo_sal_ord_mng->get_mode(  ) = 'MODIFY' THEN '007' )
                                        v1 = lv_sal_ord_id
                                        severity = CONV #( 'S' ) )
   ) TO reported-header.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
