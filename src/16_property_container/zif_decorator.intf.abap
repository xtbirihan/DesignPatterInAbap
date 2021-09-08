interface ZIF_DECORATOR
  public .

TYPES tt_konp TYPE STANDARD TABLE OF konp WITH DEFAULT KEY.
METHODS decorate
    IMPORTING
    !io_bag TYPE REF TO zcl_bag
    CHANGING
    !ct_konp TYPE tt_konp.

endinterface.
