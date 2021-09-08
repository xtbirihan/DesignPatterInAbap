interface ZIF_IMPORT_REGULATION
  public .

    methods:
      is_Allowed
        importing   i_Item_Type     type string
        returning   value(result)   type abap_bool.

endinterface.
