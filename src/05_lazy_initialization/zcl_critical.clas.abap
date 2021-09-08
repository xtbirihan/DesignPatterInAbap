CLASS zcl_critical DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    METHODS constructor.
    METHODS do_critical_stuff IMPORTING iv_error_occurred TYPE abap_bool.
    METHODS get_error_obj RETURNING VALUE(ro_obj) TYPE REF TO zcl_error.
PROTECTED SECTION.
PRIVATE SECTION.
DATA go_error TYPE REF TO zcl_error.
ENDCLASS.


CLASS zcl_critical IMPLEMENTATION.
  METHOD constructor.

  ENDMETHOD.

  METHOD do_critical_stuff.
  DATA: lt_bapiret2 TYPE bapiret2_tab,
        lv_error_occurred TYPE abap_bool.

    IF lv_error_occurred EQ abap_true.
        get_error_obj( ).
        go_error->add_messages( ).
    ENDIF.
  ENDMETHOD.

  METHOD get_error_obj.
    IF go_error IS INITIAL .
        go_error = NEW #( ).
    ENDIF.
    ro_obj = go_error.
  ENDMETHOD.

ENDCLASS.
