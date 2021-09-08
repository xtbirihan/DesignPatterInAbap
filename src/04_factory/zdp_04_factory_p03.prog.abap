*&---------------------------------------------------------------------*
*& Report zdp_pg_factory
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_04_factory_p03.

class lcl_Main definition.
  public section.
    class-methods:
      run,
      print_New_Document
        importing   i_Editor   type ref to zif_Editor.
endclass.


class lcl_Main implementation.
  method run.
    data:
      editor    type ref to zif_Editor.
    create object editor type zcl_Text_Editor.
    print_New_Document( editor ).
  endmethod.

  method print_New_Document.
    data:
    document  type ref to zif_Document.
    document = i_Editor->create_Document( |COPYRIGHT BY { sy-uname }| ).
    document->print( ).
  endmethod.
endclass.

start-of-selection.
  lcl_Main=>run( ).
