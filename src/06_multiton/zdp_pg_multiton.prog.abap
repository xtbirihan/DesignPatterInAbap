*&---------------------------------------------------------------------*
*& Report zdp_pg_multiton
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_pg_multiton.

START-OF-SELECTION.
DATA(lo_object) = zcl_vendor=>get_instance( '1903' ).
lo_object->get_instance( '1986'  ).
lo_object->get_instance( '1903'  ).

WRITE 'Multiton'.
