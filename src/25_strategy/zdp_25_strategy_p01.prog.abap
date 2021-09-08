*&---------------------------------------------------------------------*
*& Report ZDP_25_STRATEGY_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_25_strategy_p01.

PARAMETERS pa_pay TYPE c. "1 - first payment, 2 - second

INTERFACE lif_payment.
  METHODS pay CHANGING c_val TYPE p.
ENDINTERFACE.

CLASS lcl_payment_1 DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_payment.
    ALIASES pay FOR lif_payment~pay.
ENDCLASS.

CLASS lcl_payment_2 DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_payment.
    ALIASES pay FOR lif_payment~pay.
ENDCLASS.

CLASS lcl_payment_1 IMPLEMENTATION.
  METHOD pay.
    "do something with c_val i.e.
    c_val = c_val - 10.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_payment_2 IMPLEMENTATION.
  METHOD pay.
    "do something else with c_val i.e.
    c_val = c_val + 50.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    "during main object creation you pass which payment you want to use for this object
    METHODS constructor IMPORTING ir_payment TYPE REF TO lif_payment.
    "later on you can change this dynamicaly
    METHODS set_payment IMPORTING ir_payment TYPE REF TO lif_payment.
    METHODS show_payment_val.
    METHODS pay.

  PRIVATE SECTION.
    DATA payment_value TYPE p.
    "reference to your interface whcih you will be working with
    "polimorphically
    DATA mr_payment TYPE REF TO lif_payment.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD constructor.
    IF ir_payment IS BOUND.
      me->mr_payment = ir_payment.
    ENDIF.
  ENDMETHOD.
  METHOD set_payment.
    IF ir_payment IS BOUND.
      me->mr_payment = ir_payment.
    ENDIF.
  ENDMETHOD.
  METHOD show_payment_val.
    WRITE /: 'Payment value is now ', me->payment_value.
  ENDMETHOD.
  "hide fact that you are using composition to access pay method
  METHOD pay.
    mr_payment->pay( CHANGING c_val = payment_value ).
  ENDMETHOD.
ENDCLASS.

DATA gr_main    TYPE REF TO lcl_main.
DATA gr_payment TYPE REF TO lif_payment.

START-OF-SELECTION.
  "client application (which uses stategy pattern)

  CASE pa_pay.
    WHEN 1.
      "create first type of payment
      CREATE OBJECT gr_payment TYPE lcl_payment_1.
    WHEN 2.
      "create second type of payment
      CREATE OBJECT gr_payment TYPE lcl_payment_2.
  ENDCASE.
  "pass payment type to main object
  CREATE OBJECT gr_main
    EXPORTING
      ir_payment = gr_payment.

  gr_main->show_payment_val( ).
  "now client doesn't know which object it is working with
  gr_main->pay( ).
  gr_main->show_payment_val( ).

  "you can also use set_payment method to set payment type dynamically
  "client would see no change
  IF pa_pay = 1.
    "now create different payment to set it dynamically
    CREATE OBJECT gr_payment TYPE lcl_payment_2.
    gr_main->set_payment( gr_payment ).
    gr_main->pay( ).
    gr_main->show_payment_val( ).
  ENDIF.


  "REFERENCE:
*https://answers.sap.com/questions/8377387/how-to-implement-strategy-pattern-in-abap-objects.html
*https://blogs.sap.com/2012/01/17/strategy-design-pattern-part-2-how-to-implement-strategy-pattern-in-sap/
