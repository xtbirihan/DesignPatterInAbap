CLASS zcl_cashier DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
      methods:
        deliver_Pizza
          importing
            i_Pizza_Type  type string
          returning
            value(result) type ref to zif_Pizza.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cashier IMPLEMENTATION.
  METHOD deliver_pizza.
data: chef  type ref to zcl_Pizza_Chef.

    case i_Pizza_Type.
      when 'HAWAI'.
        create object chef type zcl_Pizza_Chef_Hawai.
      when 'GREEK'.
        create object chef type zcl_Pizza_Chef_Greek.
      when others.
        " we don´t serve that is it really okay to return nothing?
        return.
    endcase.

    chef->create_Dough( ).
    chef->create_Cheese( ).
    chef->create_Topping( ).

    result = chef->get_Pizza( ).
  ENDMETHOD.

ENDCLASS.
