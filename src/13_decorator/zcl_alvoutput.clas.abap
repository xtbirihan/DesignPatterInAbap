CLASS zcl_alvoutput DEFINITION
  PUBLIC
  INHERITING FROM zcl_output
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  METHODS: process_output REDEFINITION.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_alvoutput IMPLEMENTATION.

  METHOD process_output.

      WRITE: / 'Standard ALV output'.
  ENDMETHOD.

ENDCLASS.
