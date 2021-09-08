CLASS zcl_op_email DEFINITION
  PUBLIC
  INHERITING FROM zcl_opdecorator
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    METHODS: process_output REDEFINITION.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_op_email IMPLEMENTATION.
  METHOD process_output.
    super->process_output( ).
    WRITE: /(10) space, 'Sending Email'.
  ENDMETHOD.

ENDCLASS.
