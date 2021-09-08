CLASS zcl_detail_report_data DEFINITION
  PUBLIC
  INHERITING FROM zcl_report_data
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  METHODS: clone REDEFINITION,
           select_data REDEFINITION.
 DATA: t_data TYPE STANDARD TABLE OF t100.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_detail_report_data IMPLEMENTATION.
  METHOD clone.
    DATA: lo_object TYPE REF TO zcl_detail_report_data.
    CREATE OBJECT lo_object.
    lo_object->t_data = me->t_data.
    ro_object = lo_object.
  ENDMETHOD.

  METHOD select_data.
    SELECT * FROM t100
      INTO TABLE t_data
      UP TO 20 ROWS
      WHERE sprsl = sy-langu.
  ENDMETHOD.

ENDCLASS.
