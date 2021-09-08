CLASS zcl_opdecorator DEFINITION
  PUBLIC
  INHERITING FROM zcl_output
  CREATE PUBLIC .

PUBLIC SECTION.
  METHODS:
      constructor
        IMPORTING io_decorator TYPE REF TO zcl_output,
      process_output REDEFINITION.
PROTECTED SECTION.
PRIVATE SECTION.
    DATA: o_decorator TYPE REF TO zcl_output.

ENDCLASS.



CLASS zcl_opdecorator IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
     me->o_decorator = io_decorator.
  ENDMETHOD.

  METHOD process_output.
   CHECK o_decorator IS BOUND.
    o_decorator->process_output( ).
  ENDMETHOD.

ENDCLASS.
