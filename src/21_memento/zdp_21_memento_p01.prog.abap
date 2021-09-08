*&---------------------------------------------------------------------*
*& Report ZDP_21_MEMENTO_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDP_21_MEMENTO_P01.

CLASS lcl_originator DEFINITION DEFERRED.

CLASS lcl_momento DEFINITION FRIENDS lcl_originator.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING iv_state TYPE string.
  PRIVATE SECTION.
    METHODS:
      get_state   RETURNING VALUE(rv_state) TYPE string.
    DATA:
      mv_state TYPE string.
ENDCLASS.

CLASS lcl_momento IMPLEMENTATION.
  METHOD constructor.
    mv_state = iv_state.
  ENDMETHOD.

  METHOD get_state.
    rv_state = mv_state.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_caretaker DEFINITION.
  PUBLIC SECTION.
    DATA:
      mo_state TYPE REF TO lcl_momento.
ENDCLASS.

CLASS lcl_originator DEFINITION.
  PUBLIC SECTION.
    METHODS:
      create_memento RETURNING VALUE(ro_memento) TYPE REF TO lcl_momento,
      set_memento IMPORTING io_memento TYPE REF TO lcl_momento,
      set_state IMPORTING iv_state TYPE string,
      get_state RETURNING VALUE(rv_state) TYPE string.
  PRIVATE SECTION.
    DATA:
      mv_state TYPE string.
ENDCLASS.

CLASS lcl_originator IMPLEMENTATION.
  METHOD set_state.
    mv_state = iv_state.
  ENDMETHOD.

  METHOD get_state.
    rv_state = mv_state.
  ENDMETHOD.

  METHOD set_memento.
    mv_state = io_memento->get_state( ).
  ENDMETHOD.

  METHOD create_memento.
    CREATE OBJECT ro_memento
      EXPORTING
        iv_state = mv_state.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: lo_originator TYPE REF TO lcl_originator,
        lo_caretaker  TYPE REF TO lcl_caretaker,
        lv_state      TYPE string.

  CREATE OBJECT lo_originator.
  lo_originator->set_state( 'ON' ).

  CREATE OBJECT lo_caretaker.
  lo_caretaker->mo_state = lo_originator->create_memento( ).

  lo_originator->set_state( 'OFF' ).
  lv_state = lo_originator->get_state( ).
  WRITE:/ lv_state.

  lo_originator->set_memento( lo_caretaker->mo_state ).

  lv_state = lo_originator->get_state( ).
  WRITE:/ lv_state.
