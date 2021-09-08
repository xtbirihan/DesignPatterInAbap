*&---------------------------------------------------------------------*
*& Report ZDP_22_OBSERVER_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDP_22_OBSERVER_P01.

CLASS main_process DEFINITION.
  PUBLIC SECTION.
    METHODS: set_state IMPORTING im_state TYPE char1.
    EVENTS: state_changed EXPORTING VALUE(new_state) TYPE char1.
  PRIVATE SECTION.
    DATA: current_state TYPE char1.
ENDCLASS.

CLASS main_process IMPLEMENTATION.
  METHOD set_state.
    current_state = im_state.
    SKIP 2.
    WRITE: / 'Main Process new state', current_state.
    RAISE EVENT state_changed EXPORTING new_state = current_state.
  ENDMETHOD.
ENDCLASS.

CLASS my_function DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: on_state_changed ABSTRACT FOR EVENT state_changed OF main_process IMPORTING new_state.
ENDCLASS.

CLASS my_alv DEFINITION INHERITING FROM my_function.
  PUBLIC SECTION.
    METHODS: on_state_changed REDEFINITION.
ENDCLASS.

CLASS my_alv IMPLEMENTATION.
  METHOD on_state_changed.
    WRITE: / 'New state in ALV processing', new_state.
  ENDMETHOD.
ENDCLASS.

CLASS my_db DEFINITION INHERITING FROM my_function.
  PUBLIC SECTION.
    METHODS: on_state_changed REDEFINITION.
ENDCLASS.

CLASS my_db IMPLEMENTATION.
  METHOD on_state_changed.
    WRITE: / 'New State in DB processing', new_state.
  ENDMETHOD.
ENDCLASS.


DATA: lo_process TYPE REF TO main_process,
      lo_alv TYPE REF TO my_alv,
      lo_db TYPE REF TO my_db.

START-OF-SELECTION.
  CREATE OBJECT: lo_process, lo_alv, lo_db.

  SET HANDLER lo_alv->on_state_changed FOR lo_process.
  SET HANDLER lo_db->on_state_changed FOR lo_process.

  lo_process->set_state( 'A' ).
  lo_process->set_state( 'B' ).
  lo_process->set_state( 'C' ).
