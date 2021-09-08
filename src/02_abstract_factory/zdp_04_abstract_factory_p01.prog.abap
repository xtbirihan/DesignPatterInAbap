*&---------------------------------------------------------------------*
*& Report ZDP_04_ABSTRACT_FACTORY_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_04_abstract_factory_p01.

CLASS lcl_obtain_data DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: read_data ABSTRACT.
ENDCLASS.

CLASS lcl_data_from_file DEFINITION INHERITING FROM lcl_obtain_data.
  PUBLIC SECTION.
    METHODS: read_data REDEFINITION.
ENDCLASS.

CLASS lcl_data_from_file IMPLEMENTATION.
  METHOD: read_data.
    WRITE: / 'Reading data from File'.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_data_from_db DEFINITION INHERITING FROM lcl_obtain_data.
  PUBLIC SECTION.
    METHODS: read_data REDEFINITION.
ENDCLASS.

CLASS lcl_data_from_db IMPLEMENTATION.
  METHOD: read_data.
    WRITE: / 'Reading data from DATABASE TABLE'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_print DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: write_data ABSTRACT.
ENDCLASS.

CLASS lcl_print_alv DEFINITION INHERITING FROM lcl_print.
  PUBLIC SECTION.
    METHODS write_data REDEFINITION.
ENDCLASS.
CLASS lcl_print_alv IMPLEMENTATION.
  METHOD write_data.
    WRITE: / 'Writing data into ALV'.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_print_simple  DEFINITION INHERITING FROM lcl_print.
  PUBLIC SECTION.
    METHODS write_data REDEFINITION.
ENDCLASS.
CLASS lcl_print_simple IMPLEMENTATION.
  METHOD write_data.
    WRITE: / 'Writing data in classic - This is actually classic'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_report DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: get_data ABSTRACT,
      print_data ABSTRACT.
  PROTECTED SECTION.
    DATA: lo_data  TYPE REF TO lcl_obtain_data,
          lo_print TYPE REF TO lcl_print.
ENDCLASS.

CLASS lcl_simple_report DEFINITION INHERITING FROM lcl_report.
  PUBLIC SECTION.
    METHODS: get_data   REDEFINITION,
      print_data REDEFINITION,
      constructor.
ENDCLASS.

CLASS lcl_simple_report IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    CREATE OBJECT: lo_data  TYPE lcl_data_from_file,
                   lo_print TYPE lcl_print_alv.
  ENDMETHOD.

  METHOD get_data.
    lo_data->read_data( ).
  ENDMETHOD.
  METHOD print_data.
    lo_print->write_data( ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_complex_report DEFINITION INHERITING FROM lcl_report.
  PUBLIC SECTION.
    METHODS: get_data REDEFINITION,
      print_data REDEFINITION,
      constructor.
ENDCLASS.
CLASS lcl_complex_report IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    CREATE OBJECT: lo_data  TYPE lcl_data_from_file,
                   lo_print TYPE lcl_print_alv.
  ENDMETHOD.
  METHOD get_data.
    lo_data->read_data( ).
  ENDMETHOD.
  METHOD print_data.
    lo_print->write_data( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: lo_simple_report  TYPE REF TO lcl_simple_report,
        lo_complex_report TYPE REF TO lcl_complex_report.

  CREATE OBJECT: lo_simple_report,
                 lo_complex_report.

  lo_simple_report->get_data( ).
  lo_simple_report->print_data( ).
  lo_complex_report->get_data( ).
  lo_complex_report->print_data( ).
