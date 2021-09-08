*&---------------------------------------------------------------------*
*& Report ZDP_26_TEMPLATE_METHOD_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_26_template_method_p01.

CLASS lcl_travel DEFINITION ABSTRACT.

  PUBLIC SECTION.

    METHODS: make_travel FINAL,
      transport_out ABSTRACT,
      day_one ABSTRACT,
      day_two ABSTRACT,
      day_three ABSTRACT,
      transport_in ABSTRACT.

ENDCLASS.

CLASS lcl_travel IMPLEMENTATION.

  METHOD make_travel.

    transport_out( ).
    day_one( ).
    day_two( ).
    day_three( ).
    transport_in( ).

  ENDMETHOD.

ENDCLASS.


CLASS lcl_type_a DEFINITION INHERITING FROM lcl_travel.

  PUBLIC SECTION.


    METHODS: transport_out REDEFINITION,
      day_one REDEFINITION,
      day_two REDEFINITION,
      day_three REDEFINITION,
      transport_in REDEFINITION.

ENDCLASS.

CLASS lcl_type_a IMPLEMENTATION.

  METHOD transport_out.
    WRITE / ' Transport by BUS'.
  ENDMETHOD.

  METHOD day_one.
    WRITE / 'Visit Museum one'.
  ENDMETHOD.

  METHOD day_two.
    WRITE / 'Visit Museum two'.
  ENDMETHOD.

  METHOD day_three.
    WRITE / 'Visit Museum three'.
  ENDMETHOD.

  METHOD transport_in.
    WRITE / 'Return BUS'.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_type_b DEFINITION INHERITING FROM lcl_travel.

  PUBLIC SECTION.

    METHODS: transport_out REDEFINITION,
      day_one REDEFINITION,
      day_two REDEFINITION,

      day_three REDEFINITION,
      transport_in REDEFINITION.

ENDCLASS.

CLASS lcl_type_b IMPLEMENTATION.

  METHOD transport_out.
    WRITE / 'Transport by PLANE'.
  ENDMETHOD.                    "transporte_ida

  METHOD day_one.
    WRITE / 'Visit City One'.
  ENDMETHOD.                    "dia_uno

  METHOD day_two.
    WRITE / 'Visit City Two'.
  ENDMETHOD.                    "dia_dos

  METHOD day_three.
    WRITE / 'Visit City Three'.
  ENDMETHOD.                    "dia_tres

  METHOD transport_in.
    WRITE / 'Return PLANE'.
  ENDMETHOD.                    "transporte_vuelta

ENDCLASS.                    "lcl_paquete_a IMPLEMENTATION

START-OF-SELECTION.

  DATA: gr_type_a TYPE REF TO lcl_type_a,
        gr_type_b TYPE REF TO lcl_type_b.


  CREATE OBJECT: gr_type_a,
                 gr_type_b.

  gr_type_a->make_travel( ).

  SKIP 2.

  gr_type_b->make_travel( ).
