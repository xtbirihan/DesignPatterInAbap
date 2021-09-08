*&---------------------------------------------------------------------*
*& Report zdp_pg_bridge
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_pg_bridge.

START-OF-SELECTION.

DATA lo_contact TYPE REF TO zif_contact.
DATA(lo_client) = NEW zcl_client( ).
lo_contact ?= lo_client.
