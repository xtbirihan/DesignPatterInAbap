CLASS zcl_facade DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    METHODS: process_report IMPORTING iv_write_type TYPE char1.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_facade IMPLEMENTATION.
  METHOD process_report.
    DATA: lo_data TYPE REF TO zcl_data.
    CREATE OBJECT lo_data.

    DATA: lo_write TYPE REF TO zif_write.
    IF iv_write_type = 'A'.
      CREATE OBJECT lo_write TYPE zcl_write_alv.
    ELSE.
      CREATE OBJECT lo_write TYPE zcl_write_log.
    ENDIF.
    lo_write->write_data( ).
  ENDMETHOD.

ENDCLASS.
