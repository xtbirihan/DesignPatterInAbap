CLASS zcl_salv_output DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    methods:display_salv importing it_data type index table.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_salv_output IMPLEMENTATION.
  METHOD display_salv.

    data:lr_data type ref to data.
    field-symbols:<fs_data> type index table.

    create data lr_data like it_data.
    assign lr_data->* to <fs_data>.
    <fs_data> = corresponding #( it_data ).

    cl_salv_table=>factory(
    exporting
      list_display = if_salv_c_bool_sap=>true
      importing
        r_salv_table = data(lo_salv)
     changing
      t_table = <fs_data>
    ).

    lo_salv->display( ).
  ENDMETHOD.

ENDCLASS.
