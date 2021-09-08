class ZCL_DAO_MATERIAL definition
  public
  create public .
public section.
  interfaces ZIF_DAO_MATERIAL .
  class-methods GETINSTANCE
    returning
      value(PINSTANCE) type ref to ZIF_DAO_MATERIAL .
  class-methods SETINSTANCE
    importing
      !PINSTANCE type ref to ZIF_DAO_MATERIAL.
protected section.
private section.
    CLASS-DATA:
       instance type ref to ZIF_DAO_MATERIAL,
       instanceObj type ref to ZCL_DAO_MATERIAL.
ENDCLASS.
CLASS ZCL_DAO_MATERIAL IMPLEMENTATION.

    method GETINSTANCE.

       if ( instance IS INITIAL ).
          CREATE OBJECT instanceObj.
          instance ?= instanceObj.
       endif.
       pInstance = instance.
    endmethod.

    method SETINSTANCE.
       instance = pInstance.
    endmethod.

    method ZIF_DAO_MATERIAL~GET.
          SELECT *
            INTO @pMARA
            FROM MARA
           WHERE matnr = @pMaterialnumber.
          ENDSELECT.
    endmethod.
ENDCLASS.
