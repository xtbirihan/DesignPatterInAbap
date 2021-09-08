CLASS zcl_stock DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
DATA: go_material TYPE REF TO zif_material READ-ONLY,
      gv_date     TYPE dats READ-ONLY.

    METHODS constructor
    IMPORTING
    !iv_matnr TYPE matnr
    !iv_date TYPE dats.

    METHODS set_start_stock IMPORTING !iv_menge TYPE menge_d.
    METHODS consume_stock IMPORTING !iv_menge TYPE menge_d.
    METHODS get_forecast_stock
    RETURNING VALUE(rv_menge) TYPE menge_D.

PROTECTED SECTION.

PRIVATE SECTION.
 DATA: gv_menge TYPE menge_d.

ENDCLASS.



CLASS zcl_stock IMPLEMENTATION.
  METHOD constructor.
    go_material = zcl_mat_factory=>get_material( iv_matnr ).
    gv_date = iv_date.
  ENDMETHOD.

  METHOD consume_stock.
    SUBTRACT iv_menge FROM gv_menge.
  ENDMETHOD.

  METHOD get_forecast_stock.
    rv_menge = gv_menge.
  ENDMETHOD.

  METHOD set_start_stock.
    gv_menge = iv_menge.
  ENDMETHOD.

ENDCLASS.
