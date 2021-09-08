CLASS zcl_text_editor DEFINITION
  PUBLIC
  INHERITING FROM zcl_editor
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  METHODS: zif_editor~create_document REDEFINITION.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_text_editor IMPLEMENTATION.
  METHOD zif_editor~create_document.
    data:
      text_Document type ref to zcl_Text_Document,
      welcome_Body  type string_Table.
    create object text_Document
      exporting
         i_Title = i_Title.
    insert `WELCOME TO TEXTEDITOR V1.0` into table welcome_Body.
    text_Document->set_Lines( welcome_Body ).
    result = text_Document.
  ENDMETHOD.

ENDCLASS.
