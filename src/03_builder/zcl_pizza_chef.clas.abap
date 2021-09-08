CLASS zcl_pizza_chef DEFINITION
  PUBLIC ABSTRACT CREATE PUBLIC.

PUBLIC SECTION.

      METHODS:
        constructor
          IMPORTING
            i_Pizza         TYPE REF TO zcl_Pizza OPTIONAL,
            create_Dough    ABSTRACT,
            create_Cheese   ABSTRACT,
            create_Topping  ABSTRACT,
            get_Pizza
          RETURNING
            VALUE(result) TYPE REF TO zif_Pizza.


PROTECTED SECTION.
      DATA:
        f_Pizza           TYPE REF TO zcl_Pizza.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pizza_chef IMPLEMENTATION.
  METHOD constructor.
    if ( i_Pizza is initial ).
      create object me->f_Pizza.
    else.
      me->f_Pizza = i_Pizza.
    endif.
  ENDMETHOD.

  METHOD get_pizza.
    result = me->f_Pizza.

  ENDMETHOD.

ENDCLASS.
