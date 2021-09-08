*&---------------------------------------------------------------------*
*& Report ZDP_28_ITERATOR_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_28_iterator_p01.

CLASS lcl_bukrs DEFINITION.

  PUBLIC SECTION.
    DATA ms_t001 TYPE t001.
    METHODS constructor IMPORTING bukrs TYPE bukrs.
    METHODS get_info RETURNING VALUE(t001) TYPE t001.

ENDCLASS.

CLASS lcl_bukrs IMPLEMENTATION.
  METHOD constructor.
    SELECT SINGLE * FROM t001 INTO ms_t001 WHERE bukrs = bukrs.
  ENDMETHOD.
  METHOD get_info.
    t001 = ms_t001.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS start.
    METHODS get_iterator RETURNING VALUE(iterator) TYPE REF TO cl_object_collection_iterator.
    METHODS get_object IMPORTING index         TYPE i
                       RETURNING VALUE(object) TYPE REF TO object .

  PROTECTED SECTION.
    DATA mr_object_collection TYPE REF TO cl_object_collection.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD start.
    DATA lr_bukrs TYPE REF TO lcl_bukrs.
    DATA lt_bukrs TYPE STANDARD TABLE OF bukrs.
    DATA lv_bukrs TYPE bukrs.
    SELECT bukrs FROM t001 INTO TABLE lt_bukrs.
    CREATE OBJECT mr_object_collection.

    LOOP AT lt_bukrs INTO lv_bukrs.
      CREATE OBJECT lr_bukrs EXPORTING bukrs = lv_bukrs.
      mr_object_collection->add( lr_bukrs ).

    ENDLOOP.
  ENDMETHOD.

  METHOD get_iterator.
    iterator = mr_object_collection->if_object_collection~get_iterator( ).
  ENDMETHOD.

  METHOD get_object.
    object = mr_object_collection->get( index ).
  ENDMETHOD.

ENDCLASS.

DATA gr_main TYPE REF TO lcl_main.

START-OF-SELECTION.
  CREATE OBJECT gr_main.

  DATA gr_iterator TYPE REF TO cl_object_collection_iterator.
  DATA gr_bukrs TYPE REF TO lcl_bukrs.
  DATA gv_butxt TYPE string.
  DATA gv_index TYPE i.
  DATA gv_bukrs TYPE bukrs.

  gr_main->start( ).
  gr_iterator = gr_main->get_iterator( ).
  WHILE gr_iterator->has_next( ).
    gr_bukrs ?= gr_iterator->get_next( ).
    gv_butxt = gr_bukrs->get_info( )-butxt.
    WRITE: / gv_butxt.
    IF gv_butxt = 'SAP A.G.'.
      gv_index = gr_iterator->get_index( ).
    ENDIF.
  ENDWHILE.


  IF gv_index IS NOT INITIAL.
    gr_bukrs ?= gr_main->get_object( gv_index ).
    gv_bukrs = gr_bukrs->get_info( )-bukrs.
    WRITE: / gv_bukrs COLOR COL_GROUP.
  ENDIF.

  gr_iterator = gr_main->get_iterator( ).

  WHILE gr_iterator->has_next( ).
    gr_bukrs ?= gr_iterator->get_next( ).
    gv_butxt = gr_bukrs->get_info( )-butxt.
    WRITE: / gv_butxt.
    IF gv_butxt = 'SAP A.G.'.
      gv_index = gr_iterator->get_index( ).
    ENDIF.
  ENDWHILE.
