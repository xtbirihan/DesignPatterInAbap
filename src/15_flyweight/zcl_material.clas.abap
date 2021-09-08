CLASS zcl_material DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES zif_material .
PROTECTED SECTION.
PRIVATE SECTION.
    DATA:
    gv_matnr TYPE matnr,
    gv_maktx TYPE maktx,
    gv_meins TYPE meins.
ENDCLASS.



CLASS zcl_material IMPLEMENTATION.
  METHOD zif_material~get_code.
    rv_matnr = gv_matnr.
  ENDMETHOD.

  METHOD zif_material~get_text.
    rv_maktx = gv_maktx.
  ENDMETHOD.

  METHOD zif_material~get_uom.
    rv_meins = gv_meins.
  ENDMETHOD.

  METHOD zif_material~set_code.
    gv_matnr = iv_matnr.
  ENDMETHOD.

  METHOD zif_material~set_text.
    gv_maktx = iv_maktx.
  ENDMETHOD.

  METHOD zif_material~set_uom.
    gv_meins = iv_meins.
  ENDMETHOD.

ENDCLASS.
