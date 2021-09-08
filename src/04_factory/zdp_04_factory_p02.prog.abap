*&---------------------------------------------------------------------*
*& Report ZDP_04_FACTORY_P02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_04_factory_p02.

PARAMETERS: p_type TYPE i.

CLASS lcl_base_writer DEFINITION.
  PUBLIC SECTION.
    TYPES:
      ty_report_type TYPE i.
    CONSTANTS:
      gc_report_pdf   TYPE ty_report_type VALUE 1,
      gc_report_write TYPE ty_report_type VALUE 2,
      gc_report_alv   TYPE ty_report_type VALUE 3.
    CLASS-METHODS:
      get_writer IMPORTING iv_type          TYPE ty_report_type DEFAULT gc_report_write
                 RETURNING VALUE(ro_writer) TYPE REF TO lcl_base_writer.
    METHODS:
      write_data.
ENDCLASS.

CLASS lcl_write_writer DEFINITION INHERITING FROM lcl_base_writer.
  PUBLIC SECTION.
    METHODS: write_data REDEFINITION.
ENDCLASS.

CLASS lcl_alv_writer DEFINITION INHERITING FROM lcl_base_writer.
  PUBLIC SECTION.
    METHODS: write_data REDEFINITION.
ENDCLASS.

CLASS lcl_pdf_writer DEFINITION INHERITING FROM lcl_base_writer.
  PUBLIC SECTION.
    METHODS: write_data REDEFINITION.
ENDCLASS.

CLASS lcl_base_writer IMPLEMENTATION.
  METHOD get_writer.
    CASE iv_type.
      WHEN gc_report_pdf.
        CREATE OBJECT ro_writer TYPE lcl_pdf_writer.
      WHEN gc_report_write.
        CREATE OBJECT ro_writer TYPE lcl_write_writer.
      WHEN gc_report_alv.
        CREATE OBJECT ro_writer TYPE lcl_alv_writer.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD write_data..
    WRITE: / 'Use factory method!'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_pdf_writer IMPLEMENTATION.
  METHOD write_data.
    WRITE: / 'Write with pdf'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_write_writer IMPLEMENTATION.
  METHOD write_data.
    WRITE: / 'Write with write'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_alv_writer IMPLEMENTATION.
  METHOD write_data.
    WRITE: / 'Write with alv'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: lo_writer TYPE REF TO lcl_base_writer.

  lo_writer = lcl_base_writer=>get_writer( p_type ).
  lo_writer->write_data( ).
