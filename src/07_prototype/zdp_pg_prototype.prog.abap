*&---------------------------------------------------------------------*
*& Report zdp_pg_prototype
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_pg_prototype.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
ENDCLASS.                    "lcl_main DEFINITION
*
CLASS lcl_main IMPLEMENTATION.
  METHOD run.
    DATA: lo_report TYPE REF TO zcl_report_data.
    CREATE OBJECT lo_report TYPE zcl_detail_report_data.
    lo_report->select_data( ).

    DATA: lo_rep_2 TYPE REF TO zcl_report_data.
    lo_rep_2 = lo_report->clone( ).

  ENDMETHOD.                    "run
ENDCLASS.                    "lcl_main IMPLEMENTATION
*
START-OF-SELECTION.
  lcl_main=>run( ).
