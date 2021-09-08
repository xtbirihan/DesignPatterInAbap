interface ZIF_EDITOR
  public .
      methods:
      "! factory method "
      create_Document
        importing   i_Title         type string
        returning   value(result)   type ref to zif_Document,
      " ... "
      resize.
endinterface.
