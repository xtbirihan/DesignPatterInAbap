CLASS zcl_email DEFINITION
  PUBLIC ABSTRACT
  INHERITING FROM zcl_message
  CREATE PUBLIC .

PUBLIC SECTION.
    METHODS send_msg REDEFINITION.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_email IMPLEMENTATION.
  METHOD send_msg.
    DATA(lv_email) = go_contact_type->get_contact_info( iv_recipient )-email.
  ENDMETHOD.

ENDCLASS.
