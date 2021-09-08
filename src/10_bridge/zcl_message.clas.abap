CLASS zcl_message DEFINITION
  PUBLIC ABSTRACT
  CREATE PUBLIC .

PUBLIC SECTION.
    METHODS constructor
    IMPORTING
    !io_contact_type TYPE REF TO zif_contact.

    METHODS send_msg ABSTRACT
    IMPORTING
    !iv_recipient TYPE char10
    !iv_message TYPE string.

PROTECTED SECTION.
    DATA go_contact_type TYPE REF TO zif_contact.
PRIVATE SECTION.
ENDCLASS.


CLASS zcl_message IMPLEMENTATION.
  METHOD constructor.
    go_contact_type = io_contact_type.
  ENDMETHOD.

ENDCLASS.
