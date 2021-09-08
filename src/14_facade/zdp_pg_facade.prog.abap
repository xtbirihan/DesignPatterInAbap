*&---------------------------------------------------------------------*
*& Report zdp_pg_facade
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_pg_facade.

START-OF-SELECTION.

  DATA: lo_facade TYPE REF TO zcl_facade.
  CREATE OBJECT lo_facade.
  lo_facade->process_report( iv_write_type = 'A' ).
