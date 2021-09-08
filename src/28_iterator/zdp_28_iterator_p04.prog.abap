*&---------------------------------------------------------------------*
*& Report ZDP_28_ITERATOR_P04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_28_iterator_p04.

INTERFACE lif_shape.
  METHODS get_area
    RETURNING
      VALUE(rv_result) TYPE float .
ENDINTERFACE.

CLASS lCL_CIRCLE DEFINITION FINAL CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: lif_shape.
    ALIASES: get_area FOR lif_shape~get_area.
    METHODS constructor
      IMPORTING
        !iv_radius TYPE float .
*    METHODS get_area
*      RETURNING
*        VALUE(rv_result) TYPE float .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA radius TYPE float .
ENDCLASS.

CLASS lCL_CIRCLE IMPLEMENTATION.
  METHOD constructor.
    radius = iv_radius.
  ENDMETHOD.

  METHOD get_area.
    CONSTANTS: pai TYPE float VALUE '3.14'.
    rv_result = pai * radius * radius.
  ENDMETHOD.
ENDCLASS.
CLASS lcl_rectangle DEFINITION FINAL CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: lif_shape.
    ALIASES: get_area FOR lif_shape~get_area.

    METHODS constructor
      IMPORTING
        !iv_height TYPE float
        !iv_width  TYPE float .
*    METHODS get_area
*      RETURNING
*        VALUE(rv_result) TYPE float .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA height TYPE float .
    DATA width TYPE float .
ENDCLASS.

CLASS lcl_rectangle IMPLEMENTATION.
  METHOD constructor.
    height = iv_height.
    width = iv_width.
  ENDMETHOD.

  METHOD get_area.
    rv_result = width * height.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: lv_result TYPE float.
  DATA(lo_container) = NEW cl_object_collection( ).
  DATA(lo_circle) = NEW lcl_circle( 1 ).
  lo_container->add( lo_circle ).

  DATA(lo_circle2) = NEW lcl_circle( 1 ).
  lo_container->add( lo_circle2 ).

  DATA(lo_rectangle) = NEW lcl_rectangle( iv_width = 1 iv_height = 2 ).
  lo_container->add( lo_rectangle ).

  DATA(lo_iterator) = lo_container->get_iterator( ).

  WHILE lo_iterator->has_next( ).
    DATA(lo_shape) = CAST lif_shape( lo_iterator->get_next( ) ).
    lv_result = lv_result + lo_shape->get_area( ).
  ENDWHILE.
  WRITE: / lv_result.
