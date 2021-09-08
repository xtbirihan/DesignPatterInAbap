*&---------------------------------------------------------------------*
*& Report ZDP_13_DECORATOR_P02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_13_decorator_p02.

PARAMETERS: p_pdf AS CHECKBOX,
            p_email AS CHECKBOX,
            p_xls AS CHECKBOX.


CLASS output DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: process_output ABSTRACT.
ENDCLASS.

CLASS alv_output DEFINITION INHERITING FROM output.
  PUBLIC SECTION.
    METHODS: process_output REDEFINITION.
ENDCLASS.

CLASS alv_output IMPLEMENTATION.
  METHOD process_output.
    WRITE: / 'Standard ALV output'.
  ENDMETHOD.
ENDCLASS.

CLASS output_decorator DEFINITION INHERITING FROM output.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_decorator TYPE REF TO output,
      process_output REDEFINITION.
  PRIVATE SECTION.
    DATA: lo_decorator TYPE REF TO output.
ENDCLASS.

CLASS output_decorator IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    me->lo_decorator = im_decorator.
  ENDMETHOD.
  METHOD process_output.
    CHECK lo_decorator IS BOUND.
    lo_decorator->process_output( ).
  ENDMETHOD.
ENDCLASS.

CLASS output_pdf DEFINITION INHERITING FROM output_decorator.
  PUBLIC SECTION.
    METHODS: process_output REDEFINITION.
ENDCLASS.

CLASS output_pdf IMPLEMENTATION.
  METHOD process_output.
    super->process_output( ).
    WRITE: /(10) space, 'Generating PDF'.
  ENDMETHOD.
ENDCLASS.

CLASS output_xls DEFINITION INHERITING FROM output_decorator.
  PUBLIC SECTION.
    METHODS: process_output REDEFINITION.
ENDCLASS.

CLASS output_xls IMPLEMENTATION.
  METHOD process_output.
    super->process_output( ).
    WRITE: /(10) space, 'Generating Excel'.
  ENDMETHOD.
ENDCLASS.

CLASS output_email DEFINITION INHERITING FROM output_decorator.
  PUBLIC SECTION.
    METHODS: process_output REDEFINITION.
ENDCLASS.

CLASS output_email  IMPLEMENTATION.
  METHOD process_output.
    super->process_output( ).
    WRITE: /(10) space, 'Sending Email'.
  ENDMETHOD.
ENDCLASS.

CLASS output_alv DEFINITION INHERITING FROM output_decorator.
  PUBLIC SECTION.
    METHODS: process_output REDEFINITION.
ENDCLASS.

CLASS output_alv IMPLEMENTATION.
  METHOD process_output.
    super->process_output( ).
    WRITE: /(10) space, 'Generating ALV'.
  ENDMETHOD.
ENDCLASS.

CLASS main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run IMPORTING im_pdf TYPE flag
                                 im_email TYPE flag
                                 im_xls TYPE flag.
ENDCLASS.

CLASS main IMPLEMENTATION.
  METHOD run.
    DATA: lo_decorator TYPE REF TO output,
          lo_pre TYPE REF TO output.

    CREATE OBJECT lo_decorator TYPE alv_output.
    lo_pre = lo_decorator.

    IF im_pdf IS NOT INITIAL.
      CREATE OBJECT lo_decorator TYPE output_pdf EXPORTING im_decorator = lo_pre.
      lo_pre = lo_decorator.
    ENDIF.
    IF im_email IS NOT INITIAL.
      CREATE OBJECT lo_decorator TYPE output_email EXPORTING im_decorator = lo_pre.
      lo_pre = lo_decorator.
    ENDIF.
    IF im_xls IS NOT INITIAL.
      CREATE OBJECT lo_decorator TYPE output_xls EXPORTING im_decorator = lo_pre.
      lo_pre = lo_decorator.
    ENDIF.

    lo_decorator->process_output( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  main=>run( im_pdf   = p_pdf
             im_email = p_email
             im_xls   = p_xls ).
