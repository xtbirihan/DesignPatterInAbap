CLASS zcl_text_document DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES zif_document .
    methods:
      constructor
        importing   i_Title        type string,
      get_Lines
        returning   value(result)  type string_Table,
      set_Lines
        importing   i_Lines        type string_Table.
PROTECTED SECTION.
PRIVATE SECTION.
    data:
      f_Title            type string,
      f_Lines            type string_Table.
ENDCLASS.



CLASS zcl_text_document IMPLEMENTATION.
  method constructor.
    me->f_Title = i_Title.
  endmethod.

  method get_Lines.
    result = me->f_Lines.
  endmethod.

  method set_Lines.
    me->f_Lines = i_Lines.
  endmethod.

  method zif_Document~print.
    data:
      line type string.
    format: reset, color col_Heading.
    write: / me->f_Title.
    format: reset.
    loop at me->f_Lines into line.
      write: / line.
    endloop.
  endmethod.

ENDCLASS.
