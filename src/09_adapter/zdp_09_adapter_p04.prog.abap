*&---------------------------------------------------------------------*
*& Report zdp_pg_adapter
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_09_adapter_p04.

class lcl_main definition create public.
  public section.
    class-methods:class_constructor,
      excute.

  private section.
    class-data:mt_data   type table of mara,
               mo_adapter type ref to zcl_abstract_output.
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
    mo_adapter = new zcl_demo_adapter( ).
    mo_adapter->display_data( mt_data ).

    "alv display
    mo_adapter = new zcl_salv_adapter( ).
    mo_adapter->display_data( mt_data ).

  endmethod.
endclass.

start-of-selection.

  lcl_main=>excute( ).
