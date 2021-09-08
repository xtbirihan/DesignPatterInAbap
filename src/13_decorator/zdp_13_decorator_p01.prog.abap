*&---------------------------------------------------------------------*
*& Report zdp_pg_decorator
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_13_decorator_p01.
CLASS mainapp DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      run IMPORTING
        iv_pdf   TYPE flag
        iv_email TYPE flag
        iv_xls   TYPE flag.
ENDCLASS.                    "mainapp DEFINITION

*
CLASS mainapp IMPLEMENTATION.
  METHOD run.
    DATA: lo_decorator TYPE REF TO zcl_output,
          lo_pre TYPE REF TO zcl_output.          " Helper Variable

    CREATE OBJECT lo_decorator TYPE zcl_alvoutput.
    lo_pre = lo_decorator.

*   testing Decorator
    IF iv_pdf IS NOT INITIAL.
      CREATE OBJECT lo_decorator TYPE zcl_op_pdf
        EXPORTING
          io_decorator = lo_pre.
      lo_pre = lo_decorator.
    ENDIF.
    IF iv_email IS NOT INITIAL.
      CREATE OBJECT lo_decorator
        TYPE zcl_op_email
        EXPORTING
          io_decorator = lo_pre.
      lo_pre = lo_decorator.
    ENDIF.
    IF iv_xls IS NOT INITIAL.
      CREATE OBJECT lo_decorator
        TYPE zcl_op_xls
        EXPORTING
          io_decorator = lo_pre.
      lo_pre  = lo_decorator.
    ENDIF.

    lo_decorator->process_output( ).

  ENDMETHOD.                    "run
ENDCLASS.

PARAMETERS: p_pdf AS CHECKBOX,
            p_email AS CHECKBOX,
            p_xls AS CHECKBOX.

START-OF-SELECTION.
  mainapp=>run( iv_pdf   = p_pdf
                iv_email = p_email
                iv_xls   = p_xls
                 ).
