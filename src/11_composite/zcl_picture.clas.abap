CLASS zcl_picture DEFINITION
  PUBLIC
  INHERITING FROM zcl_shape
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    METHODS: constructor IMPORTING im_name TYPE string,
             add REDEFINITION,
             remove REDEFINITION,
             display REDEFINITION.
PROTECTED SECTION.
PRIVATE SECTION.
    DATA: lt_shapes TYPE STANDARD TABLE OF REF TO zcl_shape.

ENDCLASS.


CLASS zcl_picture IMPLEMENTATION.
 METHOD constructor.
    super->constructor( im_name ).
  ENDMETHOD.
  METHOD add.
    APPEND im_shape TO lt_shapes.
  ENDMETHOD.
  METHOD remove.
    DELETE lt_shapes WHERE TABLE_LINE EQ im_shape.
  ENDMETHOD.
  METHOD display.
    DATA: lo_shape TYPE REF TO zcl_shape,
          lv_indent TYPE i.
    WRITE : /.
    DO im_indent TIMES.
      WRITE: (2) '-'.
    ENDDO.
    WRITE: lv_name.
    lv_indent = im_indent + 1.
    LOOP AT lt_shapes INTO lo_shape.
      lo_shape->display( lv_indent ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
