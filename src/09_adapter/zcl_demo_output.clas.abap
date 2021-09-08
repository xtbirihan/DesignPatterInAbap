CLASS zcl_demo_output DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    methods: display_demo importing it_data type index table.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_demo_output IMPLEMENTATION.
  METHOD display_demo.

    cl_demo_output=>display_data( it_data ).

  ENDMETHOD.

ENDCLASS.
