*&---------------------------------------------------------------------*
*& Report ZDP_09_ADAPTER_P03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_09_adapter_p03.

CLASS demo_output DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS: display_demo IMPORTING it_data TYPE INDEX TABLE.
ENDCLASS.

CLASS demo_output IMPLEMENTATION.
  METHOD display_demo.
    cl_demo_output=>display_data( it_data ).
  ENDMETHOD.
ENDCLASS.

CLASS salv_output DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS:display_salv IMPORTING it_data TYPE INDEX TABLE.
ENDCLASS.

CLASS salv_output IMPLEMENTATION.
  METHOD display_salv.

    DATA:lr_data TYPE REF TO data.
    FIELD-SYMBOLS:<fs_data> TYPE INDEX TABLE.

    CREATE DATA lr_data LIKE it_data.
    ASSIGN lr_data->* TO <fs_data>.
    <fs_data> = CORRESPONDING #( it_data ).

    cl_salv_table=>factory(
    EXPORTING
      list_display = if_salv_c_bool_sap=>true
      IMPORTING
        r_salv_table = DATA(lo_salv)
     CHANGING
      t_table = <fs_data>
    ).

    lo_salv->display( ).
  ENDMETHOD.
ENDCLASS.

CLASS abstract_output DEFINITION ABSTRACT CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS:display_data IMPORTING it_data TYPE INDEX TABLE.
ENDCLASS.
CLASS abstract_output IMPLEMENTATION.
  METHOD display_data.
    MESSAGE 'Display function is not implemented' TYPE 'E'.
  ENDMETHOD.
ENDCLASS.

CLASS demo_adapter DEFINITION INHERITING FROM abstract_output CREATE PUBLIC FINAL.

  PUBLIC SECTION.
    METHODS: display_data REDEFINITION.
  PRIVATE SECTION.
    DATA:mo_output TYPE  REF TO demo_output.
ENDCLASS.

CLASS demo_adapter IMPLEMENTATION.
  METHOD display_data.
    mo_output = NEW demo_output( ).
    mo_output->display_demo( it_data ).
  ENDMETHOD.
ENDCLASS.

class salv_adapter definition inheriting from abstract_output create public final.

  public section.
    methods: display_data redefinition.
  private section.
    data:mo_output type  ref to salv_output.
endclass.

class salv_adapter implementation.
  method display_data.
    mo_output = new salv_output( ).
    mo_output->display_salv( it_data = it_data ).
  endmethod.
endclass.

"Program Execution Entry
class lcl_main definition create public.
  public section.
    class-methods:class_constructor,
      excute.

  private section.
    class-data:mt_data   type table of mara,
               mo_adapter type ref to abstract_output.
endclass.
class lcl_main implementation.
  method class_constructor.

    select *
      into table @mt_data
      up to 10 rows
      from mara.

  endmethod.
  method excute.
    "demo display
    mo_adapter = new demo_adapter( ).
    mo_adapter->display_data( mt_data ).

    "alv display
    mo_adapter = new salv_adapter( ).
    mo_adapter->display_data( mt_data ).

  endmethod.
endclass.

start-of-selection.

  lcl_main=>excute( ).
