CLASS zcl_utopia_customs DEFINITION
  PUBLIC FINAL CREATE PUBLIC .

PUBLIC SECTION.
    interfaces: zif_Customs.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_UTOPIA_CUSTOMS IMPLEMENTATION.


  METHOD zif_customs~get_import_tax.
    " Utopia as gentle and wealthy country does not charge imports "
    result = 0.
  ENDMETHOD.
ENDCLASS.
