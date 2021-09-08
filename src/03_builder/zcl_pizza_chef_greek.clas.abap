CLASS zcl_pizza_chef_greek DEFINITION
  PUBLIC
  INHERITING FROM zcl_pizza_chef
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  METHODS: create_dough REDEFINITION,
           create_cheese REDEFINITION,
           create_topping REDEFINITION.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pizza_chef_greek IMPLEMENTATION.
  method create_Dough.
    me->f_Pizza->add_Dough( 'PAN PIZZA' ).
  endmethod.

  method create_Cheese.
    me->f_Pizza->add_Cheese( 'FETA CHEESE' ).
  endmethod.

  method create_Topping.
    me->f_Pizza->add_Topping( 'OLIVES' ).
  endmethod.


ENDCLASS.
