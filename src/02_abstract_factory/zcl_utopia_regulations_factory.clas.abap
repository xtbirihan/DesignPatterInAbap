CLASS zcl_utopia_regulations_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    INTERFACES: zif_Regulations_Factory.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.


CLASS zcl_utopia_regulations_factory IMPLEMENTATION.
  METHOD zif_regulations_factory~create_customs.

    result = NEW zcl_Utopia_Customs(  ).

  ENDMETHOD.

  METHOD zif_regulations_factory~create_import_regulation.

    result = NEW zcl_Utopia_Import_Regulation( ).

  ENDMETHOD.

ENDCLASS.
