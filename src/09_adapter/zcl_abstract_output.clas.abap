CLASS zcl_abstract_output definition PUBLIC abstract create public.

PUBLIC SECTION.
    methods:display_data importing it_data type index table.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abstract_output IMPLEMENTATION.
  METHOD display_data.
    message 'Display function is not implemented' type 'E'.

  ENDMETHOD.

ENDCLASS.
