CLASS zrk_cx_rap_qry_msg_container DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cx_gateway
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !textid             LIKE if_t100_message=>t100key OPTIONAL
        !previous           LIKE previous OPTIONAL
        !batch_content_id   LIKE batch_content_id OPTIONAL
        !exception_category TYPE ty_exception_category DEFAULT gcs_excep_categories-provider
        !http_status_code   TYPE ty_http_status_code DEFAULT gcs_http_status_codes-sv_internal_server_error
        !is_for_user        TYPE abap_bool DEFAULT abap_true
*        !message_container  TYPE REF TO /iwbep/if_v4_message_container OPTIONAL
        !message_target     TYPE string OPTIONAL
        !message_targets    TYPE ty_t_message_target OPTIONAL
        !sap_note_id        TYPE ty_sap_note_id OPTIONAL
        !v4_response_info   TYPE REF TO object OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrk_cx_rap_qry_msg_container IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous           = previous
        batch_content_id   = batch_content_id
        exception_category = exception_category
        http_status_code   = http_status_code
        is_for_user        = is_for_user
        message_container  = message_container
        message_target     = message_target
        message_targets    = message_targets
        sap_note_id        = sap_note_id
        v4_response_info   = v4_response_info.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
