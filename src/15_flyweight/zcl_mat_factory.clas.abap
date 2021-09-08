CLASS zcl_mat_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    CLASS-METHODS get_material
    IMPORTING
    !iv_matnr TYPE matnr
    RETURNING
    VALUE(ro_mat) TYPE REF TO zif_material.

PROTECTED SECTION.
PRIVATE SECTION.

    TYPES: BEGIN OF t_mat,
            matnr TYPE matnr,
            obj TYPE REF TO zif_material,
           END OF t_mat,
    tt_mat TYPE HASHED TABLE OF t_mat
    WITH UNIQUE KEY primary_key COMPONENTS matnr.
    CLASS-DATA gt_mat TYPE tt_mat.
ENDCLASS.



CLASS zcl_mat_factory IMPLEMENTATION.
  METHOD get_material.
        ASSIGN gt_mat[ KEY primary_key COMPONENTS matnr = iv_matnr ] TO FIELD-SYMBOL(<ls_mat>).
        IF sy-subrc NE 0.
            SELECT SINGLE mara~matnr, mara~meins, makt~maktx
                INTO @DATA(ls_db)
                FROM mara
                LEFT JOIN makt ON makt~matnr EQ mara~matnr
                      AND makt~spras EQ @sy-langu
                    WHERE mara~matnr EQ @iv_matnr .

            DATA(ls_mat) = VALUE t_mat( matnr = iv_matnr ).
            DATA(lo_mat) = NEW zcl_material( ).

            ls_mat-obj ?= lo_mat.
            ls_mat-obj->set_code( ls_db-matnr ).
            ls_mat-obj->set_text( ls_db-maktx ).
            ls_mat-obj->set_uom( ls_db-meins ).
            INSERT ls_mat INTO TABLE gt_mat ASSIGNING <ls_mat>.

        ENDIF.
        ro_mat = <ls_mat>-obj.
  ENDMETHOD.

ENDCLASS.
