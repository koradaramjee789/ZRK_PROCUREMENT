CLASS zrk_cx_msg DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF c_sup_le_match,
        msgid TYPE symsgid VALUE 'ZRK_MESSAGES',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'GV_SUPPLIER',
        attr2 TYPE scx_attrname VALUE 'GV_COMP_CODE',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF c_sup_le_match ,
      BEGIN OF c_fwd_buyer,
        msgid TYPE symsgid VALUE 'ZRK_MESSAGES',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'GV_BUYER',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF c_fwd_buyer ,
      BEGIN OF c_pc_created,
        msgid TYPE symsgid VALUE 'ZRK_MESSAGES',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'GV_OBJECT_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF c_pc_created  ,

      BEGIN OF c_draft_doc_no_appr,
        msgid TYPE symsgid VALUE 'ZRK_MESSAGES',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF c_draft_doc_no_appr ,
      BEGIN OF c_pc_changed,
        msgid TYPE symsgid VALUE 'ZRK_MESSAGES',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'GV_OBJECT_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF c_pc_changed ,
      BEGIN OF c_create_no_auth,
        msgid TYPE symsgid VALUE 'ZRK_MESSAGES',
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF c_create_no_auth ,
      BEGIN OF c_compcode_no_auth,
        msgid TYPE symsgid VALUE 'ZRK_MESSAGES',
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF c_compcode_no_auth .

    DATA : gv_supplier  TYPE zrk_sup_no,
           gv_comp_code TYPE zrk_company_code,
           gv_buyer     TYPE zrk_name,
           gv_object_id TYPE zrk_object_id.

    METHODS constructor
      IMPORTING
        severity  TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        supplier  TYPE zrk_sup_no OPTIONAL
        comp_code TYPE zrk_company_code OPTIONAL
        buyer     TYPE zrk_name  OPTIONAL
        object_id TYPE zrk_object_id OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZRK_CX_MSG IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->if_abap_behv_message~m_severity = severity.
    me->gv_supplier  = supplier.
    me->gv_comp_code = comp_code.
    me->gv_buyer     = buyer.
    me->gv_object_id = object_id.

  ENDMETHOD.
ENDCLASS.
