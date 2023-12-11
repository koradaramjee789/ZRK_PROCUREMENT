CLASS lhc_purconatt DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS read FOR READ
      IMPORTING keys FOR READ PurConAtt RESULT result.

    METHODS rba_Purcon FOR READ
      IMPORTING keys_rba FOR READ PurConAtt\_Purcon FULL result_requested RESULT result LINK association_links.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE PurConAtt.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE PurConAtt.

ENDCLASS.


CLASS lhc_purconatt IMPLEMENTATION.
  METHOD read.
  ENDMETHOD.

  METHOD rba_Purcon.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.
ENDCLASS.


CLASS lhc_purconitemcond DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE PurConItemCond.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE PurConItemCond.

    METHODS read FOR READ
      IMPORTING keys FOR READ PurConItemCond RESULT result.

    METHODS rba_Purconitem FOR READ
      IMPORTING keys_rba FOR READ PurConItemCond\_Purconitem FULL result_requested RESULT result LINK association_links.

    METHODS rba_Purcon FOR READ
      IMPORTING keys_rba FOR READ PurConItemCond\_Purcon FULL result_requested RESULT result LINK association_links.

    METHODS set_default_for_cond FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurConItemCond~set_default_for_cond.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR PurConItemCond RESULT result.

ENDCLASS.


CLASS lhc_purconitemcond IMPLEMENTATION.
  METHOD update.
    DATA lo_pur_con_new TYPE REF TO zrk_cl_mng_pur_con.

    DATA lt_item_conds  TYPE zrk_tt_pur_cond_i.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_cba>).
*        LOOP AT <fs_cba>-%target ASSIGNING FIELD-SYMBOL(<fs_cba_target>).
*        APPEND INITIAL LINE TO lt_item_conds ASSIGNING FIELD-SYMBOL(<fs_cond>).
      IF lo_pur_con_new IS NOT BOUND.
        lo_pur_con_new = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = <fs_cba>-ConUuid ).
        EXIT.
      ENDIF.

*    ENDLOOP.
    ENDLOOP.

    lt_item_conds = CORRESPONDING #( entities MAPPING FROM ENTITY USING CONTROL ).
    lo_pur_con_new->add_item_conds( it_item_conds = lt_item_conds  ).
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Purconitem.
  ENDMETHOD.

  METHOD rba_Purcon.
  ENDMETHOD.

  METHOD set_default_for_cond.
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurConItemCond
         BY \_PurConItem
         FIELDS ( ConItemUuid Currency )
         WITH CORRESPONDING #( keys )
         LINK DATA(lt_item_cond).

    IF lt_item_cond IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurConItem
         FIELDS ( Currency )
         WITH VALUE #( ( %is_draft   = lt_item_cond[ 1 ]-target-%is_draft
                         ConItemUuid = lt_item_cond[ 1 ]-target-ConItemUuid ) )
         RESULT DATA(lt_con_items).

    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurConItem
         BY \_PurConItemCond
         ALL FIELDS
         WITH VALUE #( ( %is_draft   = lt_item_cond[ 1 ]-target-%is_draft
                         ConItemUuid = lt_item_cond[ 1 ]-target-ConItemUuid ) )
         RESULT DATA(lt_con_item_conds).

    DATA(lv_line_count) = lines( lt_con_item_conds ).
    MODIFY ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
           ENTITY PurConItemCond
           UPDATE FIELDS ( CondType Currency )
           WITH VALUE #( FOR <fs_rec> IN lt_item_cond
                         ( %tky     = <fs_rec>-source-%tky
                           Currency = VALUE #( lt_con_items[ 1 ]-Currency OPTIONAL )
                           CondType = COND #( WHEN lv_line_count = 1 THEN 'PBPR' )  ) )
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(lt_reported)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(lt_failed).

    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurConItem
         BY \_PurConItemCond
         ALL FIELDS
         WITH VALUE #( ( %is_draft   = lt_item_cond[ 1 ]-target-%is_draft
                         ConItemUuid = lt_item_cond[ 1 ]-target-ConItemUuid ) )
         RESULT lt_con_item_conds.
  ENDMETHOD.

  METHOD get_instance_features.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
      <fs_result> = CORRESPONDING #( <fs_key> ).
      <fs_result>-%features-%field-Currency = if_abap_behv=>fc-f-read_only.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.


CLASS lhc_purconitem DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE PurConItem.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE PurConItem.

    METHODS read FOR READ
      IMPORTING keys FOR READ PurConItem RESULT result.

    METHODS rba_Purcon FOR READ
      IMPORTING keys_rba FOR READ PurConItem\_Purcon FULL result_requested RESULT result LINK association_links.

    METHODS rba_Purconitemcond FOR READ
      IMPORTING keys_rba FOR READ PurConItem\_Purconitemcond FULL result_requested RESULT result LINK association_links.

    METHODS cba_Purconitemcond FOR MODIFY
      IMPORTING entities_cba FOR CREATE PurConItem\_Purconitemcond.

    METHODS set_item_no FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurConItem~set_item_no.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE PurConItem.

    METHODS On_Item_change FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurConItem~On_Item_change.

ENDCLASS.


CLASS lhc_purconitem IMPLEMENTATION.
  METHOD update.
    DATA lt_item_upd TYPE zrk_tt_pur_con_i.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_item_upd>).

      IF sy-tabix = 1.
        DATA(lo_pur_con) = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = <fs_item_upd>-ConUuid ).
      ENDIF.

      APPEND VALUE #( con_uuid             = <fs_item_upd>-ConUuid
                      con_item_uuid        = <fs_item_upd>-ConItemUuid
                      item_no              = <fs_item_upd>-ItemNo
                      description          = <fs_item_upd>-Description
                      part_no              = <fs_item_upd>-PartNo
                      unit                 = <fs_item_upd>-Unit
                      comm_code            = <fs_item_upd>-CommCode
                      quantity             = <fs_item_upd>-Quantity
                      price                = <fs_item_upd>-Price
                      currency             = <fs_item_upd>-Currency
                      src_req_no           = <fs_item_upd>-SrcReqNo
                      src_req_item         = <fs_item_upd>-SrcReqItem
                      src_ord_no           = <fs_item_upd>-SrcOrdNo
                      src_ord_item         = <fs_item_upd>-SrcOrdNo
                      created_by           = <fs_item_upd>-CreatedBy
                      created_at           = <fs_item_upd>-CreatedAt
                      last_changed_by      = <fs_item_upd>-LastChangedBy
                      last_changed_at      = <fs_item_upd>-LastChangedAt
                      locl_last_changed_at = <fs_item_upd>-LoclLastChangedAt ) TO lt_item_upd.

    ENDLOOP.

    lo_pur_con->upd_item( it_item = lt_item_upd ).
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Purcon.
  ENDMETHOD.

  METHOD rba_Purconitemcond.
  ENDMETHOD.

  METHOD cba_Purconitemcond.
    DATA lo_pur_con_new TYPE REF TO zrk_cl_mng_pur_con.

    DATA lt_item_conds  TYPE zrk_tt_pur_cond_i.

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<fs_cba>).
*        LOOP AT <fs_cba>-%target ASSIGNING FIELD-SYMBOL(<fs_cba_target>).
*        APPEND INITIAL LINE TO lt_item_conds ASSIGNING FIELD-SYMBOL(<fs_cond>).
      IF lo_pur_con_new IS NOT BOUND.
        lo_pur_con_new = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = <fs_cba>-ConItemUuid ).
      ENDIF.

      lt_item_conds = CORRESPONDING #( <fs_cba>-%target MAPPING FROM ENTITY USING CONTROL ).
      lo_pur_con_new->add_item_conds( it_item_conds = lt_item_conds  ).
*    ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_item_no.
    DATA lv_new_item_no TYPE zrk_item_no.

    READ ENTITIES OF zrk_i_pur_con_ud
         IN LOCAL MODE
         ENTITY PurConItem BY \_purCon
         FROM CORRESPONDING #( keys )
         LINK DATA(lt_con_links).

    IF lt_con_links IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zrk_i_pur_con_ud
         IN LOCAL MODE
         ENTITY PurCon BY \_PurConItem
         ALL FIELDS
         WITH VALUE #( ( %is_draft = lt_con_links[ 1 ]-target-%is_draft
                         conuuid   = lt_con_links[ 1 ]-target-ConUuid ) )
         RESULT DATA(lt_con_items).

    SORT lt_con_items BY ItemNo DESCENDING.

    lv_new_item_no = VALUE #( lt_con_items[ 1 ]-ItemNo OPTIONAL ) + 10.

    DELETE lt_con_items WHERE ConItemUuid <> keys[ 1 ]-%key-ConItemUuid.

    MODIFY ENTITIES OF zrk_i_pur_con_ud
           IN LOCAL MODE
           ENTITY PurConItem
           UPDATE FIELDS ( ItemNo )
           WITH VALUE #( FOR <fs_rec> IN lt_con_items
                         ( %tky   = <fs_rec>-%tky
                           ItemNo = lv_new_item_no ) )
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED DATA(lt_mapped_items)
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(lt_reported)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(lt_failed).

    DATA lt_cond_create TYPE TABLE FOR CREATE zrk_i_pur_con_ud\\PurConItem\_PurConItemCond.
    APPEND INITIAL LINE TO lt_cond_create ASSIGNING FIELD-SYMBOL(<fs_cond_item_create>).
    <fs_cond_item_create>-%tky        = keys[ 1 ]-%tky.
    <fs_cond_item_create>-ConItemUuid = keys[ 1 ]-%key-ConItemUuid.
    APPEND INITIAL LINE TO <fs_cond_item_create>-%target ASSIGNING FIELD-SYMBOL(<fs_cond_create>).
    <fs_cond_create>-%is_draft   = if_abap_behv=>mk-on.
    <fs_cond_create>-CondUuid    = cl_system_uuid=>create_uuid_x16_static( ).
    <fs_cond_create>-ConItemUuid = keys[ 1 ]-%key-ConItemUuid.
    <fs_cond_create>-ConUuid     = lt_con_items[ 1 ]-ConUuid.
    <fs_cond_create>-%control-CondUuid    = if_abap_behv=>mk-on.
    <fs_cond_create>-%control-ConItemUuid = if_abap_behv=>mk-on.
    <fs_cond_create>-%control-ConUuid     = if_abap_behv=>mk-on.

    MODIFY ENTITIES OF zrk_i_pur_con_ud
           IN LOCAL MODE
           ENTITY PurConItem
           CREATE BY \_PurConItemcond FROM lt_cond_create
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED DATA(lt_mapped_create_cond)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(lt_failed_create_cond)
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(lt_reported_create_cond).
  ENDMETHOD.

  METHOD create.
    IF 1 = 2.

    ENDIF.
  ENDMETHOD.

  METHOD On_Item_change.
    DATA lt_con_item_conds_upd TYPE TABLE FOR UPDATE zrk_i_pur_con_ud\\purconitemcond.

    READ ENTITIES OF zrk_i_pur_con_ud
         IN LOCAL MODE
         ENTITY PurConItem
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con_items).

    IF lt_con_items IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zrk_i_pur_con_ud
         IN LOCAL MODE
         ENTITY PurConItem BY \_PurConItemCond
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con_item_conds).

    IF lt_con_item_conds IS NOT INITIAL.

      lt_con_item_conds_upd = VALUE #( FOR <fs_item> IN lt_con_items
                                       FOR <fs_cond> IN lt_con_item_conds WHERE ( ConItemUuid = <fs_item>-ConItemUuid )
                                       ( %tky     = <fs_cond>-%tky
                                         Currency = <fs_item>-Currency ) ).

      MODIFY ENTITIES OF zrk_i_pur_con_ud
             IN LOCAL MODE
             ENTITY PurConItemCond
             UPDATE FIELDS ( Currency )
             WITH lt_con_item_conds_upd
             " TODO: variable is assigned but never used (ABAP cleaner)
             FAILED DATA(lt_failed)
             " TODO: variable is assigned but never used (ABAP cleaner)
             REPORTED DATA(lt_reported)
             " TODO: variable is assigned but never used (ABAP cleaner)
             MAPPED DATA(lt_mapped).

    ENDIF.
  ENDMETHOD.
ENDCLASS.


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

    METHODS rba_Purconitem FOR READ
      IMPORTING keys_rba FOR READ PurCon\_Purconitem FULL result_requested RESULT result LINK association_links.

    METHODS cba_Purconitem FOR MODIFY
      IMPORTING entities_cba FOR CREATE PurCon\_Purconitem.

    METHODS set_output_med FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurCon~set_output_med.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE PurCon.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~Resume.

    METHODS Activate FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~Activate.

    METHODS Edit FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~Edit.

    METHODS refresh_doc FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~refresh_doc RESULT result.

    METHODS rba_aTtachments FOR READ
      IMPORTING keys_rba FOR READ PurCon\aTtachments FULL result_requested RESULT result LINK association_links.

    METHODS cba_aTtachments FOR MODIFY
      IMPORTING entities_cba FOR CREATE PurCon\aTtachments.

    METHODS Send_For_Approval FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~Send_For_Approval RESULT result.

    METHODS Renewal_doc FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~Renewal_doc RESULT result.

    METHODS getDetails FOR READ
      IMPORTING keys FOR FUNCTION PurCon~getDetails RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR PurCon RESULT result.

    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING REQUEST requested_features FOR PurCon RESULT result.

    METHODS Partial_PR_To_PC FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~Partial_PR_To_PC.

    METHODS SetUrgentFlag FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurCon~SetUrgentFlag.
    METHODS UploadExcel FOR MODIFY
      IMPORTING keys FOR ACTION PurCon~UploadExcel RESULT result.

    METHODS precheck_UploadExcel FOR PRECHECK
      IMPORTING keys FOR ACTION PurCon~UploadExcel.

ENDCLASS.


CLASS lhc_PurCon IMPLEMENTATION.
  METHOD get_instance_features.
    READ ENTITIES OF zrk_i_pur_con_ud
         IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( ConUuid ObjectId Buyer StatCode ReleasedAtLeastOnce )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con).

    LOOP AT lt_con ASSIGNING FIELD-SYMBOL(<fs_con>).

      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
      <fs_result> = CORRESPONDING #( <fs_con> ).
      IF <fs_con>-StatCode = 'AWAP'.
        <fs_result>-%action-Send_For_Approval = if_abap_behv=>fc-o-disabled.
        <fs_result>-%action-Forward           = if_abap_behv=>fc-o-disabled.
        <fs_result>-%update = if_abap_behv=>fc-o-disabled.

      ENDIF.

      IF <fs_con>-Buyer = 'BUY0000005'.
        <fs_result>-%action-Forward = if_abap_behv=>fc-o-disabled.
      ENDIF.

      IF <fs_con>-%is_draft = if_abap_behv=>mk-on.
        <fs_result>-%field-BuyerDisp = if_abap_behv=>fc-f-read_only.
*        <fs_result>-%field-Buyer = if_abap_behv=>fc-f-read_only .
      ENDIF.

      IF <fs_con>-ReleasedAtLeastOnce = abap_true.
        <fs_result>-%field-Supplier = if_abap_behv=>fc-f-read_only.
      ENDIF.

    ENDLOOP.

*    result = VALUE #( FOR <fs_key> IN keys ( %tky = <fs_key>-%tky
*                                             %action-Forward = COND #( WHEN line_exists( lt_con[ %tky = <fs_key>-%tky  Buyer = '' ] )
*                                                                      THEN if_abap_behv=>fc-o-disabled
*                                                                      ELSE if_abap_behv=>fc-o-enabled )
*                                             %action-Send_For_Approval = COND #( WHEN line_exists( lt_con[ %key = <fs_key>-%key StatCode = 'AWAP' ] )
*                                                                      THEN if_abap_behv=>fc-o-disabled
*                                                                      ELSE if_abap_behv=>fc-o-enabled
*                                                      ) ) ) .

*      result =  VALUE #( FOR <fs_key> IN keys (  %tky = <fs_key>-%tky
*                                                %features-%action-Edit
**                                                 %delete  = COND #( WHEN line_exists( lt_con[ objectid = <fs_key>-ObjectId itemno = <fs_key>-itemno ] )
**                                                                  THEN if_abap_behv=>fc-o-disabled
**                                                                  ELSE if_abap_behv=>fc-o-enabled )
*                                                                   ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
    " Get company code from user attributes
    DATA lv_compcode TYPE zrk_company_code VALUE 'CC28'.

    READ ENTITIES OF zrk_i_pur_con_ud
         IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( ConUuid CompCode )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con).

    LOOP AT lt_con ASSIGNING FIELD-SYMBOL(<fs_con>).

      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
      <fs_result> = CORRESPONDING #( <fs_con> ).
      IF <fs_con>-CompCode IS NOT INITIAL AND <fs_con>-CompCode <> lv_compcode.
        <fs_result>-%action-Send_For_Approval = if_abap_behv=>auth-unauthorized.
        <fs_result>-%action-Forward           = if_abap_behv=>auth-unauthorized.
        <fs_result>-%action-Edit              = if_abap_behv=>auth-unauthorized.
        <fs_result>-%delete = if_abap_behv=>auth-unauthorized.
        <fs_result>-%update = if_abap_behv=>auth-unauthorized.
        APPEND VALUE #( %msg    = NEW zrk_cx_msg( textid   = zrk_cx_msg=>c_compcode_no_auth
                                                  severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on )
               TO reported-purcon.
      ENDIF.

      IF <fs_con>-Buyer = 'BUY0000005'.
        <fs_result>-%action-Forward = if_abap_behv=>fc-o-disabled.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD create.
    DATA ls_pur_con TYPE zrk_t_pur_con.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

      ls_pur_con-client          = sy-mandt.
      ls_pur_con-con_uuid        = COND #( WHEN <fs_entity>-ConUuid IS NOT INITIAL
                                           THEN <fs_entity>-ConUuid
                                           ELSE cl_system_uuid=>create_uuid_x16_static( ) ).
      ls_pur_con-object_id       = <fs_entity>-ObjectId.
      ls_pur_con-description     = <fs_entity>-Description.
      ls_pur_con-buyer           = <fs_entity>-Buyer.
      ls_pur_con-supplier        = <fs_entity>-Supplier.
      ls_pur_con-sup_con_id      = <fs_entity>-SupConId.
      ls_pur_con-send_via        = <fs_entity>-SendVia.
      ls_pur_con-comp_code       = <fs_entity>-CompCode.
      ls_pur_con-stat_code       = <fs_entity>-StatCode.
      ls_pur_con-target_value    = <fs_entity>-TargetValue.
      ls_pur_con-currency        = <fs_entity>-currency.
      ls_pur_con-valid_from      = <fs_entity>-Validfrom.
      ls_pur_con-valid_to        = <fs_entity>-ValidTo.
      ls_pur_con-fiscl_year      = <fs_entity>-FisclYear.
      ls_pur_con-version_no      = <fs_entity>-VersionNo.
      ls_pur_con-urgent_flag     = <fs_entity>-urgent_flag.
      ls_pur_con-urgent_comments = <fs_entity>-urgent_comments.
      ls_pur_con-created_at      = <fs_entity>-CreatedAt.
      ls_pur_con-created_by      = <fs_entity>-CreatedBy.

      ls_pur_con-stat_code       = 'SAVE'.

      DATA(lo_pur_con_new) = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = <fs_entity>-ConUuid ).
      " TODO: variable is assigned but never used (ABAP cleaner)
      DATA(lv_Object_Id) = lo_pur_con_new->create( is_pur_con = ls_pur_con ).

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

*      DATA(lo_pur_con) = NEW zrk_cl_mng_pur_con(  <fs_entity>-ConUuid ).
      DATA(lo_pur_con) = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = <fs_entity>-ConUuid ).
      DATA(ls_pur_con) = lo_pur_con->get( ).

      ls_pur_con-client          = sy-mandt.
      ls_pur_con-con_uuid        = COND #( WHEN <fs_entity>-%control-ConUuid = '01'
                                           THEN <fs_entity>-ConUuid
                                           ELSE ls_pur_con-con_uuid ).
      ls_pur_con-object_id       = COND #( WHEN <fs_entity>-%control-ObjectId = '01'
                                           THEN <fs_entity>-ObjectId
                                           ELSE ls_pur_con-object_id ).
      ls_pur_con-description     = COND #( WHEN <fs_entity>-%control-Description = '01'
                                           THEN <fs_entity>-Description
                                           ELSE ls_pur_con-description ).
      ls_pur_con-buyer           = COND #( WHEN <fs_entity>-%control-Buyer = '01'
                                           THEN <fs_entity>-Buyer
                                           ELSE ls_pur_con-buyer ).
      ls_pur_con-supplier        = <fs_entity>-Supplier.
      ls_pur_con-sup_con_id      = <fs_entity>-SupConId.
      ls_pur_con-comp_code       = COND #( WHEN <fs_entity>-%control-CompCode = '01'
                                           THEN <fs_entity>-CompCode
                                           ELSE ls_pur_con-comp_code ).
      ls_pur_con-send_via        = COND #( WHEN <fs_entity>-%control-SendVia = '01'
                                           THEN <fs_entity>-SendVia
                                           ELSE ls_pur_con-send_via ).
      ls_pur_con-stat_code       = <fs_entity>-StatCode.
      ls_pur_con-target_value    = COND #( WHEN <fs_entity>-%control-TargetValue = '01'
                                           THEN <fs_entity>-TargetValue
                                           ELSE ls_pur_con-Target_Value ).
      ls_pur_con-currency        = COND #( WHEN <fs_entity>-%control-currency = '01'
                                           THEN <fs_entity>-currency
                                           ELSE ls_pur_con-currency ).
      ls_pur_con-valid_from      = COND #( WHEN <fs_entity>-%control-ValidFrom = '01'
                                           THEN <fs_entity>-Validfrom
                                           ELSE ls_pur_con-valid_from ).
      ls_pur_con-valid_to        = COND #( WHEN <fs_entity>-%control-ValidTo = '01'
                                           THEN <fs_entity>-ValidTo
                                           ELSE ls_pur_con-valid_To ).
      ls_pur_con-fiscl_year      = COND #( WHEN <fs_entity>-%control-fisclyear = '01'
                                           THEN <fs_entity>-fisclyear
                                           ELSE ls_pur_con-fiscl_year ).
      ls_pur_con-version_no      = COND #( WHEN <fs_entity>-%control-VersionNo = '01'
                                           THEN <fs_entity>-VersionNo
                                           ELSE ls_pur_con-version_no ).
      ls_pur_con-urgent_flag     = COND #( WHEN <fs_entity>-%control-urgent_flag = '01'
                                           THEN <fs_entity>-urgent_flag
                                           ELSE ls_pur_con-urgent_flag ).
      ls_pur_con-urgent_comments = COND #( WHEN <fs_entity>-%control-urgent_comments = '01'
                                           THEN <fs_entity>-urgent_comments
                                           ELSE ls_pur_con-urgent_comments ).
      ls_pur_con-created_at      = <fs_entity>-CreatedAt.
      ls_pur_con-created_by      = COND #( WHEN <fs_entity>-%control-CreatedBy = '01'
                                           THEN <fs_entity>-CreatedBy
                                           ELSE ls_pur_con-created_by ).

      ls_pur_con-stat_code       = 'SAVE'.

      lo_pur_con->modify( is_pur_con = ls_pur_con ).

    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).

      DATA(lo_pur_con) = zrk_cl_mng_pur_con=>get_instance( <fs_key>-ConUuid ).
      lo_pur_con->delete( ).
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).

      DATA(lo_pur_con) = zrk_cl_mng_pur_con=>get_instance( <fs_key>-ConUuid ).
      DATA(ls_pur_con) = lo_pur_con->get( ).

      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
      <fs_result>-%tky              = <fs_key>-%tky.
      <fs_result>-ConUuid           = ls_pur_con-con_uuid.
      <fs_result>-ObjectId          = ls_pur_con-object_id.
      <fs_result>-Description       = ls_pur_con-description.
      <fs_result>-Buyer             = ls_pur_con-buyer.
      <fs_result>-Supplier          = ls_pur_con-supplier.
      <fs_result>-SupConId          = ls_pur_con-sup_con_id.
      <fs_result>-SendVia           = ls_pur_con-send_via.
      <fs_result>-StatCode          = ls_pur_con-stat_code.
      <fs_result>-CompCode          = ls_pur_con-comp_code.
      <fs_result>-ValidFrom         = ls_pur_con-valid_from.
      <fs_result>-ValidTo           = ls_pur_con-valid_to.
      <fs_result>-FisclYear         = ls_pur_con-fiscl_year.
      <fs_result>-VersionNo         = ls_pur_con-version_no.
      <fs_result>-CreatedBy         = ls_pur_con-created_by.
      <fs_result>-CreatedAt         = ls_pur_con-created_at.
      <fs_result>-LastChangedBy     = ls_pur_con-last_changed_by.
      <fs_result>-LastChangedAt     = ls_pur_con-last_changed_at.
      <fs_result>-LoclLastChangedAt = ls_pur_con-locl_last_changed_at.

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

    MODIFY ENTITIES OF zrk_i_pur_con_ud
           IN LOCAL MODE
           ENTITY PurCon
           UPDATE FIELDS ( ObjectId Description ValidFrom ValidTo FisclYear Buyer CompCode VersionNo )
           WITH VALUE #( FOR <fs_con> IN lt_con
                         ( %tky        = <fs_con>-%tky
                           ObjectId    = <fs_con>-ObjectId
                           Description = 'New PC'
                           ValidFrom   = cl_abap_context_info=>get_system_date( )
                           ValidTo     = cl_abap_context_info=>get_system_date( ) + 364
                           Buyer       = sy-uname
                           CompCode    = 'CC28'
                           FisclYear   = '2023'
                           VersionNo   = 1
                           CreatedBy   = sy-uname
                           urgent_flag = abap_false ) ).
  ENDMETHOD.

  METHOD Forward.
    " /.. Get new buyer information
    READ TABLE keys ASSIGNING FIELD-SYMBOL(<fs_key>) INDEX 1.
    IF sy-subrc = 0.
      DATA(lv_new_buyer) = <fs_key>-%param-ToBeBuyer.
    ENDIF.

    " /..Create a draft instance for all active instance
    " /.. There could be multiple records mixed with draft/active when multi-select is enabled.

    MODIFY ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
           ENTITY PurCon
           EXECUTE edit FROM
           VALUE #( FOR <fs_active_key> IN keys WHERE ( %is_draft = if_abap_behv=>mk-off )
                    ( %key                    = <fs_active_key>-%key
                      %param-preserve_changes = 'X' ) )
                 " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(edit_reported)
           " TODO: variable is assigned but never used (ABAP cleaner)
           FAILED DATA(edit_failed)
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED DATA(edit_mapped).

    DATA(lt_temp_keys) = keys.
    LOOP AT lt_temp_keys ASSIGNING FIELD-SYMBOL(<fs_temp_keys>).
      <fs_temp_keys>-%is_draft = if_abap_behv=>mk-on.
    ENDLOOP.

    " /.. Read the existing Data
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( Buyer )
         WITH CORRESPONDING #( lt_temp_keys )
         RESULT DATA(lt_buyer).

    " /.. Then modify the draft instance but not active instance
    MODIFY ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
           ENTITY PurCon
           UPDATE FIELDS ( Buyer BuyerDisp )
           WITH VALUE #( FOR <fs_rec_draft> IN lt_buyer
                         ( %tky      = <fs_rec_draft>-%tky
                           %is_draft = '01'
                           Buyer     = lv_new_buyer
                           BuyerDisp = lv_new_buyer ) )
           REPORTED edit_reported
           FAILED edit_failed
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED DATA(lt_updated).

    " /.. Read the data to send back to UI. / Optional - This is to check if the values are updated ?
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         ALL FIELDS
         WITH CORRESPONDING #( lt_temp_keys )
         RESULT DATA(lt_buyer_updated).

    " /.. Pass the data to UI.
    result = CORRESPONDING #( lt_buyer_updated ).

*    IF lt_buyer_updated IS NOT INITIAL.
*
*      zrk_cl_email_service=>send_email(
*          im_sender    = 'koradaramjee@outlook.com'
*          im_subject   = 'Document has been forwarded to you'
*          im_receipent = 'koradaramjee@gmail.com'
*          im_body      = 'Document has been forwarded to you. Please check your inbox in the Contract application!!' ).
*
*      SELECT SINGLE name FROM zrk_md_buyer WHERE buyer_id = @lv_new_buyer INTO @DATA(lv_new_buyer_name).
*      IF sy-subrc <> 0.
*        CLEAR lv_new_buyer_name.
*      ENDIF.
*      APPEND VALUE #( %tky              = <fs_temp_keys>-%tky
*                      %msg              = NEW zrk_cx_msg( severity = if_abap_behv_message=>severity-success
*                                                          textid   = zrk_cx_msg=>c_fwd_buyer
*                                                          buyer    = lv_new_buyer_name )
*                      %element-supplier = if_abap_behv=>mk-on
*                      %element-compcode = if_abap_behv=>mk-on )
*             TO reported-purcon.
*    ENDIF.
  ENDMETHOD.

  METHOD rba_Purconitem.
    IF 1 = 2.

    ENDIF.
  ENDMETHOD.

  METHOD cba_Purconitem.
    DATA lt_item_upd TYPE zrk_tt_pur_con_i.

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<fs_cba_entity>).

*      DATA(lo_pur_con) = NEW zrk_cl_mng_pur_con(  <fs_cba_entity>-ConUuid ).
      DATA(lo_pur_con) = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = <fs_cba_entity>-ConUuid ).
      " TODO: variable is assigned but never used (ABAP cleaner)
      DATA(ls_pur_con) = lo_pur_con->get( ).

      LOOP AT <fs_cba_entity>-%target ASSIGNING FIELD-SYMBOL(<fs_item_ins>).

        APPEND VALUE #( con_uuid             = <fs_item_ins>-ConUuid
                        con_item_uuid        = <fs_item_ins>-ConItemUuid
                        item_no              = <fs_item_ins>-ItemNo
                        description          = <fs_item_ins>-Description
                        part_no              = <fs_item_ins>-PartNo
                        unit                 = <fs_item_ins>-Unit
                        comm_code            = <fs_item_ins>-CommCode
                        quantity             = <fs_item_ins>-Quantity
                        price                = <fs_item_ins>-Price
                        currency             = <fs_item_ins>-Currency
                        src_req_no           = <fs_item_ins>-SrcReqNo
                        src_req_item         = <fs_item_ins>-SrcReqItem
                        src_ord_no           = <fs_item_ins>-SrcOrdNo
                        src_ord_item         = <fs_item_ins>-SrcOrdNo
                        created_by           = <fs_item_ins>-CreatedBy
                        created_at           = <fs_item_ins>-CreatedAt
                        last_changed_by      = <fs_item_ins>-LastChangedBy
                        last_changed_at      = <fs_item_ins>-LastChangedAt
                        locl_last_changed_at = <fs_item_ins>-LoclLastChangedAt )
               TO lt_item_upd.

      ENDLOOP.

      lo_pur_con->add_item( it_item = lt_item_upd ).

*      lo_pur_con->save_document( ).

    ENDLOOP.
  ENDMETHOD.

  METHOD set_output_med.
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( Supplier SupConId SendVia sent_via_text )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con).

    IF lt_con IS NOT INITIAL.

    ENDIF.

    SELECT sup_con_id, app_access, email_id
      FROM zrk_md_sup_con AS a
      INNER JOIN @lt_con AS b ON a~sup_con_id = b~SupConId
      INTO TABLE @DATA(lt_sup_con_data).
    IF sy-subrc = 0.
      SORT lt_sup_con_data BY sup_con_id.
    ENDIF.

    LOOP AT lt_con ASSIGNING FIELD-SYMBOL(<fs_con>).
      READ TABLE lt_sup_con_data ASSIGNING FIELD-SYMBOL(<fs_sup_con>)
           WITH KEY sup_con_id = <fs_con>-SupConId BINARY SEARCH.
      IF sy-subrc = 0.
        IF <fs_sup_con>-app_access = abap_true.
          <fs_con>-SendVia       = 'EDI'.
          <fs_con>-sent_via_text = 'Application'.
        ELSEIF <fs_sup_con>-email_id IS NOT INITIAL.
          <fs_con>-SendVia       = 'MAI'.
          <fs_con>-sent_via_text = 'Mail'.
        ELSE.
          <fs_con>-SendVia       = 'PRN'.
          <fs_con>-sent_via_text = 'Print'.
        ENDIF.
      ELSE.
        <fs_con>-SendVia = 'PRN'.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF zrk_i_pur_con_ud
           IN LOCAL MODE
           ENTITY PurCon
           UPDATE FIELDS ( SendVia sent_via_text )
           WITH VALUE #( FOR <fs_rec> IN lt_con
                         ( %tky          = <fs_rec>-%tky
                           SendVia       = <fs_rec>-SendVia
                           sent_via_text = <fs_rec>-sent_via_text ) ).
  ENDMETHOD.

  METHOD precheck_update.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

      IF NOT ( <fs_entity>-%control-Supplier = '01' OR <fs_entity>-%control-CompCode = '01' ).
        CONTINUE.
      ENDIF.

      READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
           ENTITY PurCon
           FIELDS ( Supplier CompCode )
           WITH VALUE #( ( %key = <fs_entity>-%key ) )
           RESULT DATA(lt_con).

      READ TABLE lt_con ASSIGNING FIELD-SYMBOL(<fs_db_con>) INDEX 1.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      <fs_db_con>-Supplier = COND #( WHEN <fs_entity>-%control-Supplier = '01'
                                     THEN <fs_entity>-Supplier
                                     ELSE <fs_db_con>-Supplier ).
      <fs_db_con>-CompCode = COND #( WHEN <fs_entity>-%control-CompCode = '01'
                                     THEN <fs_entity>-CompCode
                                     ELSE <fs_db_con>-compcode ).

      IF NOT zrk_cl_mng_pur_con=>validate_supp_le( iv_supplier  = <fs_db_con>-Supplier
                                                   iv_comp_code = <fs_db_con>-CompCode ).

        APPEND VALUE #( %tky = <fs_entity>-%tky ) TO failed-purcon.

*          APPEND VALUE #( %tky = <fs_entity>-%tky
*                          %state_Area = 'VALIDATE_SUP_LE'
*                          )
*                          TO reported-purcon.

        APPEND VALUE #( %tky              = <fs_entity>-%tky
*                         %state_Area = 'VALIDATE_SUP_LE'
                        %msg              = NEW zrk_cx_msg( severity  = if_abap_behv_message=>severity-error
                                                            textid    = zrk_cx_msg=>c_sup_le_match
                                                            supplier  = <fs_db_con>-Supplier
                                                            comp_code = <fs_db_con>-CompCode  )
                        %element-supplier = if_abap_behv=>mk-on
                        %element-compcode = if_abap_behv=>mk-on )
               TO reported-purcon.

      ELSE.

        APPEND VALUE #( %tky        = <fs_entity>-%tky
                        %state_Area = 'VALIDATE_SUP_LE' )
               TO reported-purcon.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD Resume.
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( Supplier CompCode )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con).

    LOOP AT lt_con ASSIGNING FIELD-SYMBOL(<fs_con>).

      IF NOT zrk_cl_mng_pur_con=>validate_supp_le( iv_supplier  = <fs_con>-Supplier
                                                   iv_comp_code = <fs_con>-CompCode ).

        APPEND VALUE #( %tky = <fs_con>-%tky ) TO failed-purcon.

        APPEND VALUE #( %tky        = <fs_con>-%tky
                        %state_Area = 'VALIDATE_SUP_LE' )
               TO reported-purcon.

        APPEND VALUE #( %tky              = <fs_con>-%tky
                        %state_Area       = 'VALIDATE_SUP_LE'
                        %msg              = NEW zrk_cx_msg( severity  = if_abap_behv_message=>severity-error
                                                            textid    = zrk_cx_msg=>c_sup_le_match
                                                            supplier  = <fs_con>-Supplier
                                                            comp_code = <fs_con>-CompCode  )
                        %element-supplier = if_abap_behv=>mk-on
                        %element-compcode = if_abap_behv=>mk-on )
               TO reported-purcon.

      ELSE.
        APPEND VALUE #( %tky        = <fs_con>-%tky
                        %state_Area = 'VALIDATE_SUP_LE' )
               TO reported-purcon.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD Activate.
*  IF 1 = 2.
*
*  ENDIF.

    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( Supplier CompCode )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con).

    LOOP AT lt_con ASSIGNING FIELD-SYMBOL(<fs_con>).

      APPEND VALUE #( %tky        = <fs_con>-%tky
                      %state_Area = 'VALIDATE_SUP_LE' )
             TO reported-purcon.

    ENDLOOP.
  ENDMETHOD.

  METHOD Edit.
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( VersionNo )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con).

    IF VALUE #( lt_con[ 1 ]-StatCode OPTIONAL ) <> 'RLSE'.
      RETURN.
    ENDIF.

    MODIFY ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
           ENTITY PurCon
           UPDATE FIELDS ( VersionNo ReleasedAtLeastOnce )
           WITH VALUE #( FOR <fs_rec_draft> IN lt_con WHERE ( StatCode = 'RLSE' )
                         ( %tky                = <fs_rec_draft>-%tky
                           %is_draft           = '01'
                           VersionNo           = <fs_rec_draft>-VersionNo + 1
                           ReleasedAtLeastOnce = abap_true ) )
           REPORTED reported
           FAILED failed
           MAPPED mapped.
  ENDMETHOD.

  METHOD refresh_doc.
    " /.. Read the existing Data
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_pur_con).

    result = VALUE #( FOR con IN lt_pur_con
                      ( %tky   = con-%tky
                        %param = con ) ).
  ENDMETHOD.

  METHOD rba_aTtachments.
  ENDMETHOD.

  METHOD cba_aTtachments.
    DATA lt_attach  TYPE zrk_tt_attach.
    DATA lo_pur_con TYPE REF TO zrk_cl_mng_pur_con.

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<fs_cba_entity>).

      IF lo_pur_con IS NOT BOUND.
        lo_pur_con = zrk_cl_mng_pur_con=>get_instance( iv_con_uuid = <fs_cba_entity>-ConUuid ).
      ENDIF.

      lt_attach = VALUE #( FOR <fs_attach> IN <fs_cba_entity>-%target
                           ( client               = sy-mandt
                             att_uuid             = <fs_attach>-AttUuid
                             obj_uuid             = <fs_attach>-ConUuid
                             attachment           = <fs_attach>-Attachment
                             mimetype             = <fs_attach>-Mimetype
                             filename             = <fs_attach>-Filename
                             created_by           = <fs_attach>-CreatedBy
                             created_at           = <fs_attach>-CreatedAt
                             last_changed_by      = <fs_attach>-LastChangedBy
                             last_changed_at      = <fs_attach>-LastChangedAt
                             locl_last_changed_at = <fs_attach>-LoclLastChangedAt ) ).

    ENDLOOP.

    IF     lo_pur_con IS BOUND
       AND lt_attach  IS NOT INITIAL.
      lo_pur_con->add_attachments( it_attachments = lt_attach ).
    ENDIF.
  ENDMETHOD.

  METHOD Send_For_Approval.
    READ TABLE keys ASSIGNING FIELD-SYMBOL(<Fs_key>) INDEX 1.
    IF sy-subrc = 0 AND <Fs_key>-%is_draft = if_abap_behv=>mk-on.

      APPEND VALUE #( %tky = <fs_key>-%tky ) TO failed-purcon.
      APPEND VALUE #( %tky = <Fs_key>-%tky
                      %msg = NEW zrk_cx_msg( severity = if_abap_behv_message=>severity-error
                                             textid   = zrk_cx_msg=>c_draft_doc_no_appr ) )
             TO reported-purcon.

    ENDIF.

    READ ENTITIES OF zrk_i_pur_con_ud
         IN LOCAL MODE
         ENTITY PurCon
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(lt_pur_con).

    IF lt_pur_con IS NOT INITIAL.
      READ TABLE lt_pur_con ASSIGNING FIELD-SYMBOL(<fs_pur_con>) INDEX 1.
      <Fs_pur_con>-StatCode = 'AWAP'.
      UPDATE zrk_t_pur_con
          SET stat_code = 'AWAP'
          WHERE con_uuid = @<fs_key>-ConUuid.
    ENDIF.

    result = VALUE #( FOR con IN lt_pur_con
                      ( %tky   = con-%tky
                        %param = con ) ).
  ENDMETHOD.

  METHOD Renewal_doc.
  ENDMETHOD.

  METHOD getDetails.
    DATA(lt_keys) = keys.
    IF lt_keys IS INITIAL.
      RETURN.
    ENDIF.

    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         ALL FIELDS
         WITH CORRESPONDING #( lt_keys )
         RESULT DATA(lt_item)
         FAILED DATA(read_failed).

    failed = CORRESPONDING #( DEEP read_failed ).

    LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<fs_item>).
      APPEND VALUE #( %tky   = <fs_item>-%tky
                      %param = CORRESPONDING #( <fs_item> ) ) TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
*    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.
*
*      AUTHORITY-CHECK OBJECT 'ZRK_PC'
*        ID 'ACTVT'      FIELD '01'.
*      IF sy-subrc NE 0.
*        result-%create = if_abap_behv=>auth-allowed.
*      ELSE.
*        result-%create = if_abap_behv=>auth-unauthorized.
*        APPEND VALUE #( %msg    = NEW zrk_cx_msg(
*                                       textid   = zrk_cx_msg=>c_create_no_auth
*                                       severity = if_abap_behv_message=>severity-error )
*                        %global = if_abap_behv=>mk-on
*                      ) TO reported-purcon.
*
*      ENDIF.
*    ENDIF.
  ENDMETHOD.

  METHOD get_global_features.
    IF requested_features-%create <> if_abap_behv=>mk-on.
      RETURN.
    ENDIF.

    AUTHORITY-CHECK OBJECT 'ZRK_PC'
                    ID 'ACTVT' FIELD '01'.
    IF sy-subrc <> 0.
      result-%create = if_abap_behv=>mk-off.
    ELSE.
      result-%create = if_abap_behv=>mk-on.
      APPEND VALUE #( %msg    = NEW zrk_cx_msg( textid   = zrk_cx_msg=>c_create_no_auth
                                                severity = if_abap_behv_message=>severity-error )
                      %global = if_abap_behv=>mk-on )
             TO reported-purcon.

    ENDIF.
  ENDMETHOD.

  METHOD Partial_PR_To_PC.
  ENDMETHOD.

  METHOD SetUrgentFlag.
    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
         ENTITY PurCon
         FIELDS ( urgent_flag )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_con).

    IF lt_con IS INITIAL.
      RETURN.
    ENDIF.

    MODIFY ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
           ENTITY PurCon
           UPDATE FIELDS ( AdhocUrgent urgent_comments )
           WITH VALUE #( FOR <fs_rec_draft> IN lt_con
                         ( %tky            = <fs_rec_draft>-%tky
                           AdhocUrgent     = COND #( WHEN <fs_rec_draft>-urgent_flag IS NOT INITIAL
                                                     THEN abap_false
                                                     ELSE abap_true )
                           urgent_comments = COND #( WHEN <fs_rec_draft>-urgent_flag IS NOT INITIAL
                                                     THEN <fs_rec_draft>-urgent_comments
                                                     ELSE abap_false )  ) ).
    " REPORTED reported
    " FAILED failed
    " MAPPED mapped.
  ENDMETHOD.
  METHOD UploadExcel.

    IF 1 = 2.

    ENDIF.
  ENDMETHOD.

  METHOD precheck_UploadExcel.


    READ ENTITIES OF zrk_i_pur_con_ud IN LOCAL MODE
     ENTITY PurCon
     FIELDS ( urgent_flag )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_con).

    LOOP AT lt_con ASSIGNING FIELD-SYMBOL(<fs_con>).

      APPEND VALUE #( %tky              = <fs_con>-%tky
                      %msg              = new_message_with_text(
                                            severity = if_abap_behv_message=>severity-warning
                                            text     = 'The document is going to expire in a month ?'
                                          ) )
             TO reported-purcon.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.


CLASS lsc_ZRK_I_PUR_CON_UD DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize          REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save              REDEFINITION.

    METHODS cleanup           REDEFINITION.

    METHODS cleanup_finalize  REDEFINITION.

ENDCLASS.


CLASS lsc_ZRK_I_PUR_CON_UD IMPLEMENTATION.
  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA(lo_pur_con_new) = zrk_cl_mng_pur_con=>get_instance( ).

    IF    lo_pur_con_new              IS INITIAL
       OR lo_pur_con_new->get_mode( ) IS INITIAL.
      RETURN.
    ENDIF.

    lo_pur_con_new->save_document( ).

    APPEND VALUE #( %is_draft = if_abap_behv=>mk-on
                    conuuid   = lo_pur_con_new->at_con_uuid
                    %msg      = NEW zrk_cx_msg( severity  = if_abap_behv_message=>severity-success
                                                textid    = COND #( WHEN lo_pur_con_new->get_mode( ) = 'MODIFY' THEN
                                                                      zrk_cx_msg=>c_pc_changed
                                                                    WHEN lo_pur_con_new->get_mode( ) = 'CREATE' THEN
                                                                      zrk_cx_msg=>c_pc_created )
                                                object_id = lo_pur_con_new->get( )-object_id ) )
           TO reported-purcon.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
