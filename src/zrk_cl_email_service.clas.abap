CLASS zrk_cl_email_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS :    send_email

      IMPORTING im_sender    TYPE cl_bcs_mail_message=>ty_address
                im_subject   TYPE cl_bcs_mail_message=>ty_subject
                im_receipent TYPE cl_bcs_mail_message=>ty_address "tyt_recipient
                im_body      TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZRK_CL_EMAIL_SERVICE IMPLEMENTATION.


  METHOD send_email.

    TRY.
        DATA(lo_mail_message) = cl_bcs_mail_message=>create_instance( ).

        lo_mail_message->set_sender( iv_address = im_sender ).
        lo_mail_message->set_subject( iv_subject = im_subject ).
        lo_mail_message->add_recipient(
          iv_address = im_receipent
*      iv_copy    = TO
        ).
        lo_mail_message->set_main( io_main = cl_bcs_mail_textpart=>create_instance(
                                               iv_content      = im_body
                                               iv_content_type = 'text/html'
*                                           iv_filename     =
                                             ) ).
        lo_mail_message->send(
          IMPORTING
            et_status      = DATA(lv_status)
            ev_mail_status = DATA(lv_mail_status)
        ).
      CATCH cx_bcs_mail INTO DATA(lx_bcs_mail).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
