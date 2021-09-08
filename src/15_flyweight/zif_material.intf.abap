interface ZIF_MATERIAL
  public .

    METHODS set_code IMPORTING !iv_matnr TYPE matnr.
    METHODS set_text IMPORTING !iv_maktx TYPE maktx.
    METHODS set_uom  IMPORTING !iv_meins TYPE meins.
    METHODS get_code RETURNING VALUE(rv_matnr) TYPE matnr.
    METHODS get_text RETURNING VALUE(rv_maktx) TYPE maktx.
    METHODS get_uom  RETURNING VALUE(rv_meins) TYPE meins.
endinterface.
