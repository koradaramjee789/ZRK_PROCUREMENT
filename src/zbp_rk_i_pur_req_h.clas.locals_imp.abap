CLASS lhc__pritem DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS assignSupplier FOR MODIFY
      IMPORTING keys FOR ACTION _PRItem~assignSupplier RESULT result.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _PRItem RESULT result.

ENDCLASS.

CLASS lhc__pritem IMPLEMENTATION.

  METHOD assignSupplier.

    DATA : lt_items TYPE TABLE FOR UPDATE zrk_i_pur_req_i.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
      DATA(lv_new_sup) = <fs_key>-%param-supplier.
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


    RESUlT = VALUE #( for <fs_res> In lt_items_updated ( %tky = <fs_res>-%tky %param = <fs_res> ) ) .


  ENDMETHOD.

  METHOD get_instance_authorizations.
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
    METHODS earlynumbering_cba_pritem FOR NUMBERING
      IMPORTING entities FOR CREATE _prhead\_pritem.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE _prhead.

ENDCLASS.

CLASS lhc__PRHead IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.

    IF 1 = 2.

    ENDIF.

  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA:
        entity TYPE STRUCTURE FOR CREATE zrk_i_pur_req_h.

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

    DATA(max_id) = number_range_key - number_range_returned_quantity.

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

    LOOP AT pr_head_read_result ASSIGNING FIELD-SYMBOL(<fs_head>).

      APPEND VALUE #( %cid = keys[ 1 ]-%cid
                      %is_draft = '01'
                      %data = CORRESPONDING #( <fs_head> EXCEPT objectId ) )
                      TO prhead ASSIGNING FIELD-SYMBOL(<fs_new_req>).
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
        CREATE FIELDS ( ObjectId Description StatCode )
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

ENDCLASS.
