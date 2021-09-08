CLASS zcl_singleton DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

PUBLIC SECTION.
    CLASS-METHODS:
      get_instance RETURNING VALUE(ret_singleton) TYPE REF TO zcl_singleton.

     METHODS:
      get_guid RETURNING VALUE(ret_guid) TYPE sysuuid_c32.

PROTECTED SECTION.
PRIVATE SECTION.
    CLASS-DATA: o_singleton TYPE REF TO zcl_singleton.
ENDCLASS.



CLASS zcl_singleton IMPLEMENTATION.
  METHOD get_guid.
     TRY.
        ret_guid = cl_system_uuid=>create_uuid_c32_static( ).
      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.

  METHOD get_instance.
   ret_singleton = o_singleton = COND #( WHEN o_singleton IS NOT BOUND then NEW #(  )
                                         ELSE o_singleton  ).
  ENDMETHOD.

ENDCLASS.
