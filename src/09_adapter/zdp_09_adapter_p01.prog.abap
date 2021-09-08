*&---------------------------------------------------------------------*
*& Report ZDP_09_ADAPTER_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_09_adapter_p01.

CLASS lcl_target DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      request ABSTRACT.
ENDCLASS.
CLASS lcl_adaptee DEFINITION.
  PUBLIC SECTION.
    METHODS:
      specialRequest.
ENDCLASS.
CLASS lcl_adaptee IMPLEMENTATION.
  METHOD specialRequest.
    WRITE: / 'Adaptee Call'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_adapter DEFINITION INHERITING FROM lcl_target.
  PUBLIC SECTION.
    METHODS:
      request REDEFINITION,
      constructor.
  PRIVATE SECTION.
    DATA:
     mo_adaptee TYPE REF TO lcl_adaptee.
ENDCLASS.
CLASS lcl_adapter IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    CREATE OBJECT mo_adaptee.
  ENDMETHOD.
  METHOD request.
    mo_adaptee->specialrequest( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA(lo_adapter) = NEW lcl_adapter( ).
  lo_adapter->request( ).
