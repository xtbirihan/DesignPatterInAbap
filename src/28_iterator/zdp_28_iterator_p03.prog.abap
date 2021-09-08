*&---------------------------------------------------------------------*
*& Report ZDP_28_ITERATOR_P03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDP_28_ITERATOR_P03.

CLASS lcl_item DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_name TYPE STRING.
    DATA: v_name TYPE STRING READ-ONLY.
ENDCLASS.                    "lcl_item DEFINITION
*
CLASS lcl_item IMPLEMENTATION.
  METHOD constructor.
    v_name = iv_name.
  ENDMETHOD.                    "constructor
ENDCLASS.                    "lcl_item IMPLEMENTATION
*
INTERFACE if_collection DEFERRED.
*
INTERFACE if_iterator.
  METHODS: get_index RETURNING VALUE(INDEX) TYPE i,
           has_next  RETURNING VALUE(has_next) TYPE flag,
           get_next  RETURNING VALUE(object) TYPE REF TO OBJECT,
           first     RETURNING VALUE(object) TYPE REF TO OBJECT,
           set_step  IMPORTING VALUE(iv_step) TYPE i.
  DATA: v_step TYPE i.
  DATA: v_current TYPE i.
  DATA: o_collection TYPE REF TO if_collection.
ENDINTERFACE.                    "if_iterator IMPLEMENTATION
*
INTERFACE if_collection.
  METHODS: get_iterator RETURNING VALUE(iterator) TYPE REF TO if_iterator.
  METHODS: ADD    IMPORTING element TYPE REF TO OBJECT,
           remove IMPORTING element TYPE REF TO OBJECT,
           CLEAR,
           SIZE   RETURNING VALUE(SIZE) TYPE i,
           is_empty RETURNING VALUE(empty) TYPE flag,
           GET    IMPORTING INDEX TYPE i
                  RETURNING VALUE(object) TYPE REF TO OBJECT.
ENDINTERFACE.                    "if_collection IMPLEMENTATION
*
CLASS lcl_iterator DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_iterator.
    METHODS: constructor IMPORTING io_collection TYPE REF TO if_collection.
    ALIASES: get_index   FOR if_iterator~get_index,
             has_next    FOR if_iterator~has_next,
             get_next    FOR if_iterator~get_next,
             first       FOR if_iterator~first,
             set_step    FOR if_iterator~set_step.

  PRIVATE SECTION.
    ALIASES: v_step      FOR if_iterator~v_step,
             v_current   FOR if_iterator~v_current,
             o_collection FOR if_iterator~o_collection.
ENDCLASS.                    "lcl_iterator DEFINITION
*
CLASS lcl_collection DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_collection.
    DATA: i_items TYPE STANDARD TABLE OF REF TO OBJECT.
    ALIASES: get_iterator   FOR if_collection~get_iterator,
             ADD            FOR if_collection~ADD,
             remove         FOR if_collection~remove,
             CLEAR          FOR if_collection~CLEAR,
             SIZE           FOR if_collection~SIZE,
             is_empty       FOR if_collection~is_empty,
             GET            FOR if_collection~GET.
ENDCLASS.                    "lcl_collection DEFINITION

*
CLASS lcl_collection IMPLEMENTATION.
  METHOD if_collection~get_iterator.
    CREATE OBJECT iterator
      TYPE
        lcl_iterator
      EXPORTING
        io_collection = me.
  ENDMETHOD.                    "if_collection~get_iterator
  METHOD if_collection~ADD.
    APPEND element TO i_items.
  ENDMETHOD.                    "if_collection~add
  METHOD if_collection~remove.
    DELETE i_items WHERE TABLE_LINE EQ element.
  ENDMETHOD.                    "if_collection~remove
  METHOD if_collection~CLEAR.
    CLEAR: i_items.
  ENDMETHOD.                    "if_collection~clear
  METHOD if_collection~SIZE.
    SIZE = LINES( i_items ).
  ENDMETHOD.                    "if_collection~size
  METHOD if_collection~is_empty.
    IF me->SIZE( ) IS INITIAL.
      empty = 'X'.
    ENDIF.
  ENDMETHOD.                    "if_collection~is_empty
  METHOD if_collection~GET.
    READ TABLE i_items INTO object INDEX INDEX.
  ENDMETHOD.                    "if_collection~get
ENDCLASS.                    "lcl_collection IMPLEMENTATION
*
CLASS lcl_iterator IMPLEMENTATION.
  METHOD constructor.
    o_collection = io_collection.
    v_step = 1.
  ENDMETHOD.                    "constructor
  METHOD if_iterator~first.
    v_current = 1.
    object = o_collection->GET( v_current ).
  ENDMETHOD.                    "if_iterator~first
  METHOD if_iterator~get_next.
    v_current = v_current + v_step.
    object = o_collection->GET( v_current ).
  ENDMETHOD.                    "if_iterator~next
  METHOD if_iterator~has_next.
    DATA obj TYPE REF TO OBJECT.
    DATA idx TYPE i.
    idx = v_current + v_step.
    obj = o_collection->GET( idx ).
    IF obj IS BOUND.
      has_next = 'X'.
    ENDIF.
  ENDMETHOD.                    "if_iterator~isdone
  METHOD if_iterator~set_step.
    me->v_step = iv_step.
  ENDMETHOD.                    "if_iterator~SET_STEP
  METHOD if_iterator~get_index.
    INDEX = INDEX.
  ENDMETHOD.                    "if_iterator~get_index
ENDCLASS.                    "iterator IMPLEMENTATION
*
CLASS lcl_linked_list DEFINITION.
  PUBLIC SECTION.
    DATA: obj  TYPE REF TO OBJECT,
          NEXT TYPE REF TO lcl_linked_list.
ENDCLASS.                    "lcl_linked_list DEFINITION

*
CLASS lcl_linked_iterator DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_iterator.
    METHODS: constructor IMPORTING io_collection TYPE REF TO if_collection.
    ALIASES: get_index   FOR if_iterator~get_index,
             has_next    FOR if_iterator~has_next,
             get_next    FOR if_iterator~get_next,
             first       FOR if_iterator~first,
             set_step    FOR if_iterator~set_step.
  PRIVATE SECTION.
    ALIASES: v_step       FOR if_iterator~v_step,
             v_current    FOR if_iterator~v_current,
             o_collection FOR if_iterator~o_collection.
ENDCLASS.                    "lcl_iterator DEFINITION
*
CLASS lcl_linked_collection DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_collection.
    DATA: o_linked_list TYPE REF TO lcl_linked_list.
    ALIASES: get_iterator   FOR if_collection~get_iterator,
             ADD            FOR if_collection~ADD,
             remove         FOR if_collection~remove,
             CLEAR          FOR if_collection~CLEAR,
             SIZE           FOR if_collection~SIZE,
             is_empty       FOR if_collection~is_empty,
             GET            FOR if_collection~GET.
  PRIVATE SECTION.
    DATA: o_last_node TYPE REF TO lcl_linked_list.
    DATA: v_size TYPE i.
ENDCLASS.                    "lcl_collection DEFINITION

*
CLASS lcl_linked_collection IMPLEMENTATION.
  METHOD if_collection~get_iterator.
    CREATE OBJECT iterator
      TYPE
        lcl_iterator
      EXPORTING
        io_collection = me.
  ENDMETHOD.                    "if_collection~get_iterator
  METHOD if_collection~ADD.
    IF o_linked_list IS NOT BOUND.
      CREATE OBJECT o_linked_list.
      o_last_node = o_linked_list.
    ENDIF.
    DATA: o_next_node TYPE REF TO lcl_linked_list.
    CREATE OBJECT o_next_node.
    o_last_node->obj ?= element.
    o_last_node->NEXT = o_next_node.
    o_last_node = o_next_node.
    v_size = v_size + 1.
  ENDMETHOD.                    "if_collection~add
  METHOD if_collection~remove.


    DATA: lo_node TYPE REF TO lcl_linked_list.
    DATA: obsolete_node TYPE REF TO lcl_linked_list.
    DATA: next_node TYPE REF TO lcl_linked_list.

    lo_node = o_linked_list.
    TRY.
        DO.
          IF lo_node->obj EQ element.
            EXIT.
          ENDIF.
          lo_node = lo_node->NEXT.
        ENDDO.
        obsolete_node = lo_node->NEXT.
        next_node = obsolete_node->NEXT.
        lo_node->NEXT = next_node.
      CATCH CX_ROOT.
        WRITE: 'Unable to delete Next Node'.
    ENDTRY.
    v_size = v_size - 1.

  ENDMETHOD.                    "if_collection~remove
  METHOD if_collection~CLEAR.
    CLEAR: o_linked_list.
  ENDMETHOD.                    "if_collection~clear
  METHOD if_collection~SIZE.
    SIZE = v_size.
  ENDMETHOD.                    "if_collection~size
  METHOD if_collection~is_empty.
    IF me->SIZE( ) IS INITIAL.
      empty = 'X'.
    ENDIF.
  ENDMETHOD.                    "if_collection~is_empty
  METHOD if_collection~GET.
    DATA: lo_node TYPE REF TO lcl_linked_list.
    lo_node = o_linked_list.
    DO INDEX TIMES.
      object  = lo_node->obj.
      lo_node = lo_node->NEXT.
    ENDDO.
  ENDMETHOD.                    "if_collection~get
ENDCLASS.                    "lcl_collection IMPLEMENTATION
*
CLASS lcl_linked_iterator IMPLEMENTATION.
  METHOD constructor.
    o_collection = io_collection.
    v_step = 1.
  ENDMETHOD.                    "constructor
  METHOD if_iterator~first.
    v_current = 1.
    object = o_collection->GET( v_current ).
  ENDMETHOD.                    "if_iterator~first
  METHOD if_iterator~get_next.
    v_current = v_current + v_step.
    object = o_collection->GET( v_current ).
  ENDMETHOD.                    "if_iterator~next
  METHOD if_iterator~has_next.
    DATA obj TYPE REF TO OBJECT.
    DATA idx TYPE i.
    idx = v_current + v_step.
    obj = o_collection->GET( idx ).
    IF obj IS BOUND.
      has_next = 'X'.
    ENDIF.
  ENDMETHOD.                    "if_iterator~isdone
  METHOD if_iterator~set_step.
    me->v_step = iv_step.
  ENDMETHOD.                    "if_iterator~SET_STEP
  METHOD if_iterator~get_index.
    INDEX = INDEX.
  ENDMETHOD.                    "if_iterator~get_index
ENDCLASS.                    "iterator IMPLEMENTATION

*
CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
ENDCLASS.                    "lcl_main DEFINITION
*
CLASS lcl_main IMPLEMENTATION.
  METHOD run.
*
    DATA: o_collection TYPE REF TO if_collection.
    DATA: o_iterator TYPE REF TO if_iterator.
    DATA: lo_item TYPE REF TO lcl_item.

    CREATE OBJECT o_collection TYPE lcl_collection.
    o_iterator = o_collection->get_iterator( ).

    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Item1'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Item2'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Item3'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Item4'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Item5'.
    o_collection->ADD( lo_item ).

    "o_iterator->set_step( 2 ).
    WHILE o_iterator->has_next( ) IS NOT INITIAL.
      lo_item ?= o_iterator->get_next( ).
      WRITE: / lo_item->v_name.
    ENDWHILE.

*   linked list
    CREATE OBJECT o_collection TYPE lcl_linked_collection.

    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Linked List Item1'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Linked List Item2'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Linked List Item3'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Linked List Item4'.
    o_collection->ADD( lo_item ).
    CREATE OBJECT lo_item
      EXPORTING
        iv_name = 'Linked List Item5'.
    o_collection->ADD( lo_item ).

*   Remove 4th object
    o_iterator = o_collection->get_iterator( ).
    DO 3 TIMES.
      lo_item ?= o_iterator->get_next( ).
    ENDDO.
    o_collection->remove( lo_item ).

*   Print all
    o_iterator = o_collection->get_iterator( ).
    WHILE o_iterator->has_next( ) IS NOT INITIAL.
      lo_item ?= o_iterator->get_next( ).
      WRITE: / lo_item->v_name.
    ENDWHILE.

  ENDMETHOD.                    "run
ENDCLASS.                    "lcl_main IMPLEMENTATION

START-OF-SELECTION.
  lcl_main=>run( ).
