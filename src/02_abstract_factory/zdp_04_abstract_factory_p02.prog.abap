*&---------------------------------------------------------------------*
*& Report zdp_pg_abstract_factory
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_04_abstract_factory_p02.

START-OF-SELECTION.

DATA(gv_allowed) = new zcl_utopia_regulations_factory( )->zif_regulations_factory~create_import_regulation( )->is_allowed( 'Animal' ).
