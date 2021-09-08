*&---------------------------------------------------------------------*
*& Report zdp_pg_builder
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_pg_builder.

 class cl_Customer definition.     " arbitrary Client Sample - just make it run
    public section.
      class-methods main.
  endclass.

class cl_Customer implementation.

  method main.
    data:
      cashier     type ref to zcl_Cashier,
      pizza       type ref to zif_Pizza,
      ingredients type string_Table.
    create object cashier.
    pizza = cashier->deliver_Pizza( 'HAWAI' ).

    ingredients = pizza->get_Ingredients( ).
    loop at ingredients into DATA(ingredient).
      write: / ingredient.
    endloop.
  endmethod.

endclass.


start-of-selection.
  cl_Customer=>main( ).
