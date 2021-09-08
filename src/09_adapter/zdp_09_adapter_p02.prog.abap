*&---------------------------------------------------------------------*
*& Report ZDP_09_ADAPTER_P02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_09_adapter_p02.

INTERFACE lif_target.
  METHODS:
    request.
ENDINTERFACE.

CLASS lcl_adaptee DEFINITION.
  PUBLIC SECTION.
    METHODS:
      specialRequest.
ENDCLASS.

CLASS lcl_adaptee IMPLEMENTATION.
  METHOD specialRequest.
    WRITE:/ 'Adaptee Call'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_adapter DEFINITION INHERITING FROM lcl_adaptee.
  PUBLIC SECTION.
    INTERFACES: lif_target.
    ALIASES request FOR lif_target~request.
ENDCLASS.

CLASS lcl_adapter IMPLEMENTATION.
  METHOD request.
    me->specialrequest( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA:
    lo_adapter TYPE REF TO lcl_adapter.

  CREATE OBJECT lo_adapter.
  lo_adapter->request( ).
