*&---------------------------------------------------------------------*
*& Report ZDP_13_DECORATOR_P03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_13_decorator_p03.

CLASS lcx_error DEFINITION INHERITING FROM cx_static_check.
  PUBLIC SECTION.
    CONSTANTS:
      gc_no_data TYPE string VALUE `No Data!`,
      gc_no_auth TYPE string VALUE `No Authorization!`.
    METHODS:
      get_text REDEFINITION.
    CLASS-METHODS:
      raise IMPORTING iv_text TYPE string RAISING lcx_error.
  PRIVATE SECTION.
    DATA:
      mv_text TYPE string.
ENDCLASS.

CLASS lcx_error IMPLEMENTATION.
  METHOD raise.
    DATA: lo_exception TYPE REF TO lcx_error.
    CREATE OBJECT lo_exception.
    lo_exception->mv_text = iv_text.

    RAISE EXCEPTION lo_exception.
  ENDMETHOD.

  METHOD get_text.
    IF mv_text IS NOT INITIAL.
      result = mv_text.
    ELSE.
      result = super->get_text( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_component DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      get_data ABSTRACT RETURNING VALUE(rt_spfli) TYPE spfli_tab
                        RAISING   lcx_error.
ENDCLASS.

CLASS lcl_concrete_component DEFINITION INHERITING FROM lcl_component.
  PUBLIC SECTION.
    METHODS:
      get_data REDEFINITION.
ENDCLASS.

CLASS lcl_concrete_component IMPLEMENTATION.
  METHOD get_data.
    SELECT * FROM spfli INTO CORRESPONDING FIELDS OF TABLE rt_spfli.
    IF sy-subrc NE 0.
      lcx_error=>raise( iv_text = lcx_error=>gc_no_data ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_decorator DEFINITION ABSTRACT INHERITING FROM lcl_concrete_component.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING io_component TYPE REF TO lcl_concrete_component.
  PROTECTED SECTION.
    DATA:
      mo_component TYPE REF TO lcl_concrete_component.
ENDCLASS.

CLASS lcl_decorator IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mo_component = io_component.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_log_decorator DEFINITION INHERITING FROM lcl_decorator.
  PUBLIC SECTION.
    METHODS:
      get_data REDEFINITION.
ENDCLASS.

CLASS lcl_log_decorator IMPLEMENTATION.
  METHOD get_data.
    WRITE: / 'Log before reading'.
    mo_component->get_data( ).
    WRITE: / 'Log after reading'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_auth_decorator DEFINITION INHERITING FROM lcl_decorator.
  PUBLIC SECTION.
    METHODS:
      get_data REDEFINITION.
ENDCLASS.

CLASS lcl_auth_decorator IMPLEMENTATION.
  METHOD get_data.
    WRITE: / 'Auth check'.
    mo_component->get_data( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA:
    lo_component TYPE REF TO lcl_concrete_component,
    lt_data      TYPE spfli_tab,
    lo_exc       TYPE REF TO lcx_error.

  CREATE OBJECT lo_component.
  TRY.
      lo_component = NEW lcl_log_decorator(
                         io_component = NEW lcl_auth_decorator(
                         io_component = NEW lcl_concrete_component( )
                       )
                     ).

      lo_component->get_data( ).

    CATCH lcx_error INTO lo_exc.
      WRITE: / lo_exc->get_text( ).
  ENDTRY.
