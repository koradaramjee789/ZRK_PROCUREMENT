CLASS lhc__pritem DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS assignSupplier FOR MODIFY
      IMPORTING keys FOR ACTION _PRItem~assignSupplier RESULT result.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _PRItem RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _PRItem RESULT result.
    METHODS precheck_assignsupplier FOR PRECHECK
      IMPORTING keys FOR ACTION _pritem~assignsupplier.
ENDCLASS.

CLASS lhc__pritem IMPLEMENTATION.

  METHOD assignSupplier.

    DATA : lt_items TYPE TABLE FOR UPDATE zrk_i_pur_req_i.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
      DATA(lv_new_sup) = <fs_key>-%param-ToBesupplier.
    ENDLOOP.

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
      ENTITY _PRItem
      FIELDS ( Supplier )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_item).

    LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<fs_item>).

      <fs_item>-Supplier = lv_new_sup.

    ENDLOOP.

    MODIFY ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
        ENTITY _PRItem
        UPDATE FIELDS ( Supplier )
        WITH CORRESPONDING #( lt_item ).

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
         ENTITY _PRItem
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(lt_items_updated).


    RESUlT = VALUE #( FOR <fs_res> IN lt_items_updated ( %tky = <fs_res>-%tky %param = <fs_res> ) ) .


  ENDMETHOD.

  METHOD get_instance_authorizations.

    IF sy-subrc EQ 0.

    ENDIF.

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
       ENTITY _PRHead BY \_PRItem
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT DATA(pr_item_read_result) FAILED failed.

    SELECT * FROM
       zrk_i_pur_req_i AS a
       INNER JOIN @pr_item_read_result AS b
       ON a~ObjectId = b~ObjectId
       AND a~ItemNo = b~ItemNo
       INTO TABLE @DATA(lt_active_items).

    IF sy-subrc = 0.

*    result =  VALUE #( for <fs_key> in keys (  %tky = <fs_key>-%tky
*                                               %acti ).

    ENDIF.


  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
     ENTITY _PRHead BY \_PRItem
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(pr_item_read_result) FAILED failed.

    SELECT a~* FROM
       zrk_i_pur_req_i AS a
       INNER JOIN @pr_item_read_result AS b
       ON a~ObjectId = b~ObjectId
       AND a~ItemNo = b~ItemNo
       INTO TABLE @DATA(lt_active_items).

    IF sy-subrc = 0.

      result =  VALUE #( FOR <fs_key> IN keys (  %tky = <fs_key>-%tky
*                                                 %update = if_abap_behv=>fc-o-disabled
                                                 %delete  = COND #( WHEN line_exists( lt_active_items[ objectid = <fs_key>-ObjectId itemno = <fs_key>-itemno ] )
                                                                  THEN if_abap_behv=>fc-o-disabled
                                                                  ELSE if_abap_behv=>fc-o-enabled )
                                                                   ) ).

    ENDIF.

  ENDMETHOD.

  METHOD precheck_assignSupplier.

    IF 1 = 2.

    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc__PRHead DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _PRHead RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _prhead RESULT result.
    METHODS copyrequisition FOR MODIFY
      IMPORTING keys FOR ACTION _prhead~copyrequisition.
    METHODS convert_into_pc FOR MODIFY
      IMPORTING keys FOR ACTION _prhead~convert_into_pc .
    METHODS completepr FOR MODIFY
      IMPORTING keys FOR ACTION _prhead~completepr RESULT result.
    METHODS earlynumbering_cba_pritem FOR NUMBERING
      IMPORTING entities FOR CREATE _prhead\_pritem.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE _prhead.

    METHODS precheck_Convert_Into_PC FOR PRECHECK
      IMPORTING keys FOR ACTION _prhead~convert_into_pc .
    METHODS Activate FOR MODIFY
      IMPORTING keys FOR ACTION _PRHead~Activate.

    METHODS Edit FOR MODIFY
      IMPORTING keys FOR ACTION _PRHead~Edit.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION _PRHead~Resume.

    METHODS DetOnModify FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _PRHead~DetOnModify.


ENDCLASS.

CLASS lhc__PRHead IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.


  ENDMETHOD.

  METHOD earlynumbering_create.


    DATA(lt_entities_generated) = entities.
    mapped-_prhead = VALUE #( FOR <fs_gen> IN entities WHERE ( ObjectId IS NOT INITIAL ) ( CORRESPONDING #( <fs_gen> ) ) ).
    DATA(lt_entities_to_gen) = entities.
    DELETE lt_entities_to_gen WHERE ObjectId IS NOT INITIAL.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*        ignore_buffer     =
            nr_range_nr       = '01'
            object            = 'ZRK_NR_PR'
            quantity          = CONV #( lines( lt_entities_to_gen ) )
*        subobject         =
*        toyear            =
          IMPORTING
                number            = DATA(number_range_key)
                returncode        = DATA(number_range_return_code)
                returned_quantity = DATA(number_range_returned_quantity)
        ).
      CATCH cx_number_ranges.
        "handle exception
    ENDTRY.

    CHECK number_range_returned_quantity = lines( lt_entities_to_gen ).

    DATA(max_id) = CONV ZRK_PC_NUMBER( number_range_key - number_range_returned_quantity ).

    LOOP AT lt_entities_to_gen ASSIGNING FIELD-SYMBOL(<fs_rec_gen>).

      max_id += 1.

      <fs_rec_gen>-ObjectId = |PR{ max_id }|.

      APPEND VALUE #( %cid = <fs_rec_gen>-%cid
                      %key = <fs_rec_gen>-%key
                      %is_draft = '01'
                      objectid = <fs_rec_gen>-ObjectId )
                      TO mapped-_prhead.

    ENDLOOP.


  ENDMETHOD.

  METHOD copyRequisition.

    DATA : prhead TYPE  TABLE FOR CREATE zrk_i_pur_req_h\\_PRHead.

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
         ENTITY _PRHead
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(pr_head_read_result) FAILED failed.

    DATA(ls_param) = keys[ 1 ]-%param .

    SELECT SINGLE name
        FROM zrk_md_buyer
        WHERE buyer_id = @ls_param-buyer
        INTO @DATA(lv_buyer_name).

    LOOP AT pr_head_read_result ASSIGNING FIELD-SYMBOL(<fs_head>).

      APPEND VALUE #( %cid = keys[ 1 ]-%cid
                      %is_draft = '01'
                      %data = CORRESPONDING #( <fs_head> EXCEPT objectId )
                      )
                      TO prhead ASSIGNING FIELD-SYMBOL(<fs_new_req>).
      <fs_new_req>-Description = ls_param-description .
      <fs_new_req>-Buyer       = ls_param-buyer.
*          <fs_new_req>-BuyerName   = lv_buyer_name.
    ENDLOOP.

    IF sy-subrc IS NOT INITIAL.

      APPEND VALUE #( %cid = keys[ 1 ]-%cid
                      %is_draft = '01'
                      %data = CORRESPONDING #( keys[ 1 ]-%param ) )
                      TO prhead ASSIGNING <fs_new_req>.

    ENDIF.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*            ignore_buffer     =
            nr_range_nr       = '01'
            object            = 'ZRK_NR_PR'
            quantity          = 1
*            subobject         =
*            toyear            =
          IMPORTING
                number            = DATA(number_range_key)
                returncode        = DATA(number_range_return_code)
                returned_quantity = DATA(number_range_returned_quantity)
        ).
      CATCH cx_number_ranges.
        "handle exception
    ENDTRY.
    DATA(max_id) = number_range_key - number_range_returned_quantity.
    <fs_new_req>-ObjectId = |PR{ max_id }|.
    <fs_new_req>-Description = COND #( WHEN <fs_new_req>-Description IS INITIAL
                                        THEN |Copy of { <fs_head>-ObjectId }|
                                       ELSE
                                         <fs_new_req>-Description ).
    <fs_new_req>-StatCode = 'OPEN'.



    CHECK prhead IS NOT INITIAL.

    MODIFY ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
        ENTITY _PRHead
        CREATE FIELDS ( ObjectId Description Buyer StatCode )
        WITH prhead
        MAPPED DATA(mapped_create)
        FAILED DATA(failed_create)
        REPORTED DATA(reported_create).


    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
         ENTITY _PRHead
         ALL FIELDS WITH CORRESPONDING #( mapped_create-_prhead )
         RESULT DATA(read_created_result).

    mapped-_prhead = mapped_create-_prhead.

  ENDMETHOD.

  METHOD earlynumbering_cba_Pritem.

    DATA : lv_max_item_no TYPE zrk_item_no.

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
        ENTITY _PRHead BY \_PRItem
        FROM CORRESPONDING #( entities )
        LINK DATA(lt_items)
        FAILED failed.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_grp_head>)
        GROUP BY <fs_grp_head>-ObjectId.

      lv_max_item_no = REDUCE #( INIT max = CONV zrk_item_no( '0' )
                                FOR item IN lt_items USING KEY entity WHERE ( source-objectid = <fs_grp_head>-ObjectId )
                                NEXT max = COND zrk_item_no( WHEN item-target-itemNo > max
                                                             THEN item-target-itemNo
                                                             ELSE max )
                                ).

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_head>)
          USING KEY entity WHERE ObjectId = <fs_grp_head>-ObjectId.

        LOOP AT <fs_head>-%target ASSIGNING FIELD-SYMBOL(<fs_item>).

          APPEND CORRESPONDING #( <fs_item> ) TO mapped-_pritem
              ASSIGNING FIELD-SYMBOL(<fs_mapped_item>).
          IF <fs_mapped_item>-ItemNo IS INITIAL.
            lv_max_item_no += 10.
            <fs_mapped_item>-ItemNo = lv_max_item_no.
          ENDIF.


        ENDLOOP.

      ENDLOOP.


    ENDLOOP.

  ENDMETHOD.

  METHOD Convert_Into_PC.

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
        ENTITY _PRHead
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_pur_req).

    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
        ENTITY _PRHead BY \_PRItem
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_pur_req_item).


    DATA(lo_pur_con) = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = cl_system_uuid=>create_uuid_x16_static(  ) ).

    DATA(ls_pr) = lt_pur_req[ 1 ].
    DATA(ls_pr_item) = lt_pur_req_item[ 1 ].

    lo_pur_con->create( is_pur_con = VALUE #(
                        client = sy-mandt
                        con_uuid = lo_pur_con->at_con_uuid
                        object_id ='PCPR1'
                        description = |Created from { ls_pr-ObjectId }|
                        buyer = ls_pr-Buyer
                        supplier = ls_pr_item-Supplier
                        sup_con_id =''
                        comp_code = zrk_cl_mng_pur_con=>get_defaults_for_create(  )-comp_code
                        stat_code =''
                        fiscl_year ='2022'
                        valid_from = cl_abap_context_info=>get_system_date( )
                        valid_to = cl_abap_context_info=>get_system_date( ) + 364
                        created_by = sy-uname
                        created_at ='0.0000000 '
                        last_changed_by = sy-uname
                        last_changed_at ='0.0000000 '
                        locl_last_changed_at ='0.0000000'

     ) ).

    lo_pur_con->add_item( it_item = VALUE #( FOR <fs_rec> IN lt_pur_req_item (
                    con_uuid = lo_pur_con->at_con_uuid
                    con_item_uuid = cl_system_uuid=>create_uuid_x16_static(  )
                    item_no = <fs_rec>-ItemNo
                    description = <fs_rec>-Description
                    part_no = <fs_rec>-PartNo
                    unit = <fs_rec>-Unit
                    comm_code = <fs_rec>-CommCode
                    quantity = <fs_rec>-Quantity
                    price = <fs_rec>-Price
                    currency = <fs_rec>-Currency
                    src_req_no = <fs_rec>-ObjectId
                    src_req_item = <fs_rec>-ItemNo
      ) ) ) .
    lo_pur_con->save_document( ).
    mapped-_prhead = CORRESPONDING #( lt_pur_req ).

    reported-_prhead = VALUE #(
        ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                        text = 'Requisition is converted into Contract' ) )
         ).

  ENDMETHOD.

  METHOD CompletePR.

*Modify the entities with required fields.
    MODIFY ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
      ENTITY _PRHead
      UPDATE FIELDS ( StatCode )
          WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                          StatCode ='CMPL' ) ).

* Check if there are any draft instances?
    DATA(lt_draft_docs) = keys.
    DELETE lt_draft_docs WHERE %is_draft = if_abap_behv=>mk-off.

    IF lt_draft_docs IS NOT INITIAL.

* EXECUTE Active only on draft instances.

      MODIFY ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
        ENTITY _PRHead
          EXECUTE Activate FROM
          VALUE #( FOR key IN keys ( %key = key-%key ) )
        REPORTED DATA(activate_reported)
        FAILED DATA(activate_failed)
        MAPPED DATA(activate_mapped).

    ENDIF.

* Change Keys to read active Instance
    DATA(lt_keys) = keys.
    LOOP AT lt_keys ASSIGNING FIELD-SYMBOL(<ls_key>).
      <ls_key>-%is_draft = if_abap_behv=>mk-off.
    ENDLOOP.

* Read the active instance to send back to Fiori App.
    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
        ENTITY _PRHead
        ALL FIELDS WITH CORRESPONDING #( lt_keys )
        RESULT DATA(lt_pur_req).

* Populate %key , %tky  to be filled from source instance while %param-%key to be filled from new instance.
    result = VALUE #( FOR <fs_old_key> IN keys
                      FOR <fs_new_key> IN lt_keys WHERE ( ObjectId = <Fs_old_key>-ObjectId )
                                                    ( %key = <fs_old_key>-%key
                                                      %tky = <fs_old_key>-%tky
                                                      %param-%key = <fs_new_key>-%key ) ).

    mapped-_prhead = CORRESPONDING #( lt_pur_req ).

  ENDMETHOD.


  METHOD precheck_convert_into_pc.

    IF 1 = 2.

    ENDIF.

  ENDMETHOD.



  METHOD Activate.
    IF 1 = 2.

    ENDIF.
  ENDMETHOD.

  METHOD Edit.
    IF 1 = 2.

    ENDIF.
  ENDMETHOD.

  METHOD Resume.
    IF 1 = 2.

    ENDIF.
  ENDMETHOD.

  METHOD DetOnModify.

*    READ ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
*   ENTITY _PRHead
*   ALL FIELDS WITH CORRESPONDING #( keys )
*   RESULT DATA(lt_head).
*
*    LOOP AT lt_head ASSIGNING FIELD-SYMBOL(<fs_head>).
*      <fs_head>-StatCode = 'OPEN'.
*    ENDLOOP.
*
*    MODIFY ENTITIES OF zrk_i_pur_req_h IN LOCAL MODE
*    ENTITY _PRHead
*    UPDATE FIELDS ( StatCode )
*    WITH VALUE #( FOR <fs_key> IN lt_head ( %tky = <fs_key>-%tky
*                                            StatCode = 'OPEN' ) )
*    REPORTED DATA(lt_reported)
*    FAILED DATA(lt_failed)
*    MAPPED DATA(lt_mapped).
*
  ENDMETHOD.





ENDCLASS.
