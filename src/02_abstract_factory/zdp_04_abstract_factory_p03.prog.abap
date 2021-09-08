*&---------------------------------------------------------------------*
*& Report ZDP_04_ABSTRACT_FACTORY_P03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDP_04_ABSTRACT_FACTORY_P03.

CLASS lcl_abstract_product_a DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: run ABSTRACT.
ENDCLASS.

CLASS lcl_abstract_product_b DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: run ABSTRACT.
ENDCLASS.

CLASS lcl_abstract_factory DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      create_product_a ABSTRACT RETURNING VALUE(ro_product_a) TYPE REF TO lcl_abstract_product_a,
      create_product_b ABSTRACT RETURNING VALUE(ro_product_b) TYPE REF TO lcl_abstract_product_b.
ENDCLASS.


CLASS lcl_concrete_product_a_1 DEFINITION INHERITING FROM lcl_abstract_product_a.
  PUBLIC SECTION.
    METHODS run REDEFINITION.
ENDCLASS.

CLASS lcl_concrete_product_a_2 DEFINITION INHERITING FROM lcl_abstract_product_a.
  PUBLIC SECTION.
    METHODS run REDEFINITION.
ENDCLASS.

CLASS lcl_concrete_product_b_1 DEFINITION INHERITING FROM lcl_abstract_product_b.
  PUBLIC SECTION.
    METHODS run REDEFINITION.
ENDCLASS.

CLASS lcl_concrete_product_b_2 DEFINITION INHERITING FROM lcl_abstract_product_b.
  PUBLIC SECTION.
    METHODS run REDEFINITION.
ENDCLASS.


CLASS lcl_concrete_factory_1 DEFINITION INHERITING FROM lcl_abstract_factory.
  PUBLIC SECTION.
    METHODS:
      create_product_a REDEFINITION,
      create_product_b REDEFINITION.
ENDCLASS.

CLASS lcl_concrete_factory_2 DEFINITION INHERITING FROM lcl_abstract_factory.
  PUBLIC SECTION.
    METHODS:
      create_product_a REDEFINITION,
      create_product_b REDEFINITION.
ENDCLASS.

CLASS lcl_concrete_product_a_1 IMPLEMENTATION.
  METHOD run.
    WRITE: / 'Run with product A-1'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_concrete_product_a_2 IMPLEMENTATION.
  METHOD run.
    WRITE: / 'Run with product A-2'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_concrete_product_b_1 IMPLEMENTATION.
  METHOD run.
    WRITE: / 'Run with product B-1'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_concrete_product_b_2 IMPLEMENTATION.
  METHOD run.
    WRITE: / 'Run with product B-2'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_concrete_factory_1 IMPLEMENTATION.
  METHOD create_product_a.
    CREATE OBJECT ro_product_a TYPE lcl_concrete_product_a_1.
  ENDMETHOD.

  METHOD create_product_b.
    CREATE OBJECT ro_product_b TYPE lcl_concrete_product_b_1.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_concrete_factory_2 IMPLEMENTATION.
  METHOD create_product_a.
    CREATE OBJECT ro_product_a TYPE lcl_concrete_product_a_2.
  ENDMETHOD.

  METHOD create_product_b.
    CREATE OBJECT ro_product_b TYPE lcl_concrete_product_b_2.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA:
    lo_factory   TYPE REF TO lcl_abstract_factory,
    lo_product_a TYPE REF TO lcl_abstract_product_a,
    lo_product_b TYPE REF TO lcl_abstract_product_b.

  CREATE OBJECT lo_factory TYPE lcl_concrete_factory_1.
  lo_product_a = lo_factory->create_product_a( ).
  lo_product_b = lo_factory->create_product_b( ).

  lo_product_a->run( ).
  lo_product_b->run( ).

  CREATE OBJECT lo_factory TYPE lcl_concrete_factory_2.
  lo_product_a = lo_factory->create_product_a( ).
  lo_product_b = lo_factory->create_product_b( ).

  lo_product_a->run( ).
  lo_product_b->run( ).
