*&---------------------------------------------------------------------*
*& Report ZDP_24_STATE_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDP_24_STATE_P01.
**"Before Pattern
**CLASS lcl_water DEFINITION.
**  PUBLIC SECTION.
**    CONSTANTS:
**      gc_state_solid    TYPE i VALUE 1,
**      gc_state_liquid   TYPE i VALUE 2,
**      gc_state_gaz      TYPE i VALUE 3.
**    METHODS:
**      constructor IMPORTING iv_state TYPE i,
**      heat,
**      frost.
**  PRIVATE SECTION.
**    DATA:
**      mv_state TYPE i.
**ENDCLASS.
**
**CLASS lcl_water IMPLEMENTATION.
**  METHOD constructor.
**    mv_state = iv_state.
**  ENDMETHOD.
**
**  METHOD heat.
**    CASE mv_state.
**      WHEN gc_state_solid.
**        WRITE: / 'Turning ice into liquid'.
**        mv_state = gc_state_liquid.
**      WHEN gc_state_liquid.
**        WRITE: / 'Turning liquid into steam'.
**        mv_state = gc_state_gaz.
**      WHEN gc_state_gaz.
**        WRITE: / 'Increasing the steam temperature'.
**    ENDCASE.
**  ENDMETHOD.
**
**  METHOD frost.
**    CASE mv_state.
**      WHEN gc_state_liquid.
**        WRITE: / 'Turning liquid into ice'.
**        mv_state = gc_state_solid.
**      WHEN gc_state_gaz.
**        WRITE: / 'Turning steam into liquid'.
**        mv_state = gc_state_liquid.
**    ENDCASE.
**  ENDMETHOD.
**ENDCLASS.
**
**START-OF-SELECTION.
**  DATA(lo_water) = NEW lcl_water( lcl_water=>gc_state_liquid ).
**  lo_water->heat( ).
**  lo_water->heat( ).
**  lo_water->frost( ).
**  lo_water->frost( ).

CLASS lcl_water DEFINITION DEFERRED.

INTERFACE lif_water_state.
  CONSTANTS:
    gc_state_solid    TYPE i VALUE 1,
    gc_state_liquid   TYPE i VALUE 2,
    gc_state_gaz      TYPE i VALUE 3.
  METHODS:
    heat IMPORTING io_water TYPE REF TO lcl_water OPTIONAL,
    frost IMPORTING io_water TYPE REF TO lcl_water OPTIONAL.
ENDINTERFACE.

CLASS lcl_water DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_water_state.
    ALIASES: heat   FOR lif_water_state~heat,
             frost  FOR lif_water_state~frost.

    METHODS:
      constructor IMPORTING io_state TYPE REF TO lif_water_state,
      set_state IMPORTING io_state TYPE REF TO lif_water_state.
  PRIVATE SECTION.
    DATA:
      mo_state TYPE REF TO lif_water_state.
ENDCLASS.

CLASS lcl_water IMPLEMENTATION.
  METHOD constructor.
    set_state( io_state ).
  ENDMETHOD.

  METHOD heat.
    mo_state->heat( me ).
  ENDMETHOD.

  METHOD frost.
    mo_state->frost( me ).
  ENDMETHOD.

  METHOD set_state.
    mo_state = io_state.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_liquid_water_state DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_water_state.
    ALIASES: heat   FOR lif_water_state~heat,
             frost  FOR lif_water_state~frost.
ENDCLASS.

CLASS lcl_solid_water_state DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_water_state.
    ALIASES: heat   FOR lif_water_state~heat,
             frost  FOR lif_water_state~frost.
ENDCLASS.

CLASS lcl_gaz_water_state DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_water_state.
    ALIASES: heat   FOR lif_water_state~heat,
             frost  FOR lif_water_state~frost.
ENDCLASS.

CLASS lcl_liquid_water_state IMPLEMENTATION.
  METHOD heat.
    WRITE: / 'Turning water into steam'.
    io_water->set_state( io_state = CAST #( NEW lcl_gaz_water_state( ) ) ).
  ENDMETHOD.

  METHOD frost.
    WRITE: / 'Turning water into ice'.
    io_water->set_state( io_state = CAST #( NEW lcl_solid_water_state( ) ) ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_solid_water_state IMPLEMENTATION.
  METHOD heat.
    WRITE: / 'Turning ice into liquid'.
    io_water->set_state( io_state = CAST #( NEW lcl_liquid_water_state( ) ) ).
  ENDMETHOD.

  METHOD frost.
    WRITE: / 'Freeze the ice one more time'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_gaz_water_state IMPLEMENTATION.
  METHOD heat.
    WRITE: / 'Increasing the steam temperature'.
  ENDMETHOD.

  METHOD frost.
    WRITE: / 'Turning steam into water'.
    io_water->set_state( io_state = CAST #( NEW lcl_liquid_water_state( ) ) ).
  ENDMETHOD.
ENDCLASS.

*&---------------------------------------------------------------------*
*&  Работа с классами шаблона
*&---------------------------------------------------------------------*

START-OF-SELECTION.
  DATA(lo_water) = NEW lcl_water( NEW lcl_liquid_water_state( ) ).

  lo_water->heat( ).
  lo_water->heat( ).
  lo_water->frost( ).
  lo_water->frost( ).
