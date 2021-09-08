CLASS zcl_demo_adapter DEFINITION
  PUBLIC
  INHERITING FROM zcl_abstract_output
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    methods: display_data redefinition.

PROTECTED SECTION.
PRIVATE SECTION.
    data:mo_output type  ref to zcl_demo_output.

ENDCLASS.


CLASS zcl_demo_adapter IMPLEMENTATION.
  METHOD display_data.
    mo_output = new zcl_demo_output( ).
    mo_output->display_demo( it_data ).
  ENDMETHOD.

ENDCLASS.
