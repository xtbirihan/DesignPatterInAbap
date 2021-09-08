interface ZIF_REGULATIONS_FACTORY
  public .

    methods:
      create_Customs
        returning   value(result)   type ref to zif_Customs,
      create_Import_Regulation
        returning   value(result)   type ref to zif_Import_Regulation.
endinterface.
