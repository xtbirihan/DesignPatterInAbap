CLASS zcl_utopia_import_regulation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    INTERFACES: zif_Import_Regulation.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_utopia_import_regulation IMPLEMENTATION.
  METHOD zif_import_regulation~is_allowed.
    " Utopia is gentle to the animals as well "
    case i_Item_Type.
      when 'ANIMAL' or 'FUR' or 'LEATHER'.
        result = abap_False.
      when others.
        result = abap_True.
    endcase.
  ENDMETHOD.

ENDCLASS.
