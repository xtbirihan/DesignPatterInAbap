CLASS zcl_pizza DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
      interfaces:
        zif_Pizza.
      methods:
        add_Dough   importing i_Dough   type string,
        add_Cheese  importing i_Cheese  type string,
        add_Topping importing i_Topping type string.

PROTECTED SECTION.
PRIVATE SECTION.
      data:
        f_Dough     type string,
        f_Cheese    type string,
        f_Topping   type string.
ENDCLASS.



CLASS zcl_pizza IMPLEMENTATION.
  METHOD add_cheese.
    me->f_Cheese = i_Cheese.
  ENDMETHOD.

  METHOD add_dough.
    me->f_Dough = i_Dough.
  ENDMETHOD.

  METHOD add_topping.
    me->f_Topping = i_Topping.
  ENDMETHOD.

  METHOD zif_pizza~get_ingredients.
    insert me->f_Dough    into table result.
    insert me->f_Cheese   into table result.
    insert me->f_Topping  into table result.
  ENDMETHOD.

ENDCLASS.
