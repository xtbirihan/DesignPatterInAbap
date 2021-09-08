CLASS zcl_bag DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

        TYPES:
        BEGIN OF t_var,
        name TYPE string,
        value TYPE REF TO data,
        END OF t_var,

        tt_var TYPE HASHED TABLE OF t_var
        WITH UNIQUE KEY primary_key COMPONENTS name.

        METHODS get_var
        IMPORTING
        !iv_name TYPE string
        RETURNING
        VALUE(rr_val) TYPE REF TO data.

        METHODS set_var
          IMPORTING
               is_var TYPE t_var.

PROTECTED SECTION.
PRIVATE SECTION.
DATA gt_var TYPE tt_var.
ENDCLASS.



CLASS zcl_bag IMPLEMENTATION.
  METHOD get_var.
    ASSIGN gt_var[ KEY primary_key COMPONENTS name = iv_name ] TO FIELD-SYMBOL(<ls_var>).
    IF <ls_var> IS NOT ASSIGNED.
      MESSAGE 'Error' TYPE 'E'.
    ENDIF.
    rr_val = <ls_var>-value.
  ENDMETHOD.

  METHOD set_var.
    ASSIGN gt_var[ KEY primary_key COMPONENTS name = is_var-name ] TO FIELD-SYMBOL(<ls_var>).
    IF <ls_var> IS NOT ASSIGNED.
        INSERT VALUE #( name = is_var-name )
                INTO TABLE gt_var ASSIGNING <ls_var>.
    ENDIF.
    <ls_var>-value = is_var-value.
  ENDMETHOD.

ENDCLASS.
