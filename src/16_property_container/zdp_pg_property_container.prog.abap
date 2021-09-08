*&---------------------------------------------------------------------*
*& Report zdp_pg_property_container
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_pg_property_container.

START-OF-SELECTION.

TYPES: tt_dec TYPE STANDARD TABLE OF REF TO zif_decorator.
DATA:lo_obj       TYPE REF TO object,
     lo_decorator TYPE REF TO zif_decorator,
     lt_clsname   TYPE STANDARD TABLE OF seometarel-clsname,
     lt_dec       TYPE tt_dec.
     TYPES tt_konp TYPE STANDARD TABLE OF konp WITH DEFAULT KEY.
DATA: xkonp TYPE tt_konp.
* Detect classes implementing our interface & build table of classes
        SELECT clsname INTO TABLE lt_clsname
        FROM seometarel
        WHERE refclsname eq 'ZIF_DECORATOR'.
 LOOP AT lt_clsname ASSIGNING FIELD-SYMBOL(<lv_clsname>).
    CREATE OBJECT lo_obj TYPE (<lv_clsname>).
    lo_decorator ?= lo_obj.
    APPEND lo_decorator TO lt_dec.
 ENDLOOP.
* Create property bag instance
DATA(lo_bag) = NEW zcl_bag( ).
* Loop through classes, letting each class modify the data
LOOP AT lt_dec ASSIGNING FIELD-SYMBOL(<lo_dec>).
<lo_dec>->decorate(
EXPORTING
io_bag = lo_bag
CHANGING
ct_konp = xkonp ).
ENDLOOP.
