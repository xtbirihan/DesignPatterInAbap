CLASS zcl_error DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
METHODS: write_to_application_log,
         send_emails,
         create_ticket,
         add_messages.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_error IMPLEMENTATION.
  METHOD create_ticket.
    WRITE 'Ticket'.
  ENDMETHOD.

  METHOD send_emails.
    WRITE 'E Mail'.
  ENDMETHOD.

  METHOD write_to_application_log.
    WRITE 'App Log'.
  ENDMETHOD.

  METHOD add_messages.
    WRITE 'Add Message'.
  ENDMETHOD.

ENDCLASS.
