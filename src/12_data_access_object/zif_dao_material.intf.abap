interface ZIF_DAO_MATERIAL
  public .
  methods GET
    importing
      !PMATERIALNUMBER type MATNR
    returning
      value(PMARA) type MARA .
endinterface.
