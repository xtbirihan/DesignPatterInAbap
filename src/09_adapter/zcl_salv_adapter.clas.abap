CLASS zcl_salv_adapter DEFINITION
  PUBLIC
  INHERITING FROM zcl_abstract_output
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    methods: display_data redefinition.

PROTECTED SECTION.
PRIVATE SECTION.
    data:mo_output type  ref to zcl_salv_output.

ENDCLASS.



CLASS zcl_salv_adapter IMPLEMENTATION.
  METHOD display_data.
    mo_output = new zcl_salv_output( ).
    mo_output->display_salv( it_data = it_data ).
  ENDMETHOD.

ENDCLASS.
