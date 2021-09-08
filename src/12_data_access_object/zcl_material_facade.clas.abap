class ZCL_MATERIAL_FACADE definition
  public
  final
  create public .
public section.
  METHODS:
       constructor,
       getGrossWeight importing pMaterialnumber type MATNR
                 returning value(pGrossWeight) type BRGEW.
protected section.
private section.
   DATA: materialDao type ref to ZIF_DAO_MATERIAL.
ENDCLASS.
CLASS ZCL_MATERIAL_FACADE IMPLEMENTATION.
       method constructor.
          materialDao = ZCL_DAO_MATERIAL=>getInstance( ).
       endmethod.
       method getGrossWeight.
           DATA: mara type MARA.
           mara = materialDao->get( pMaterialnumber ).
           pGrossWeight = mara-brgew.
       endmethod.
ENDCLASS.
