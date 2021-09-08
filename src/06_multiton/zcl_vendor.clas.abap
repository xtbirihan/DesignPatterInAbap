CLASS zcl_vendor DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

PUBLIC SECTION.
    DATA gv_lifnr TYPE lifnr READ-ONLY.

    CLASS-METHODS get_instance
      IMPORTING !iv_lifnr TYPE lifnr
      RETURNING VALUE(ro_obj) TYPE REF TO zcl_vendor.

PROTECTED SECTION.
PRIVATE SECTION.
   TYPES:
      BEGIN OF t_multiton,
        lifnr TYPE lifnr,
        obj TYPE REF TO zcl_vendor,
      END OF t_multiton,

      tt_multiton TYPE HASHED TABLE OF t_multiton
        WITH UNIQUE KEY primary_key COMPONENTS lifnr.

    CLASS-DATA gt_multiton TYPE tt_multiton.

    METHODS constructor
      IMPORTING
        !iv_lifnr TYPE lifnr.
ENDCLASS.



CLASS zcl_vendor IMPLEMENTATION.
  METHOD constructor.
    gv_lifnr = iv_lifnr.
  ENDMETHOD.

  METHOD get_instance.
    ASSIGN gt_multiton[ KEY primary_key COMPONENTS lifnr = iv_lifnr ]
                                        TO FIELD-SYMBOL(<ls_multiton>).

    IF sy-subrc NE 0.

      DATA(ls_multiton) = VALUE t_multiton( lifnr = iv_lifnr ).
      ls_multiton-obj = NEW #( iv_lifnr ).
      INSERT ls_multiton
        INTO TABLE gt_multiton
        ASSIGNING <ls_multiton>.

    ENDIF.

    ro_obj = <ls_multiton>-obj.
  ENDMETHOD.

ENDCLASS.
