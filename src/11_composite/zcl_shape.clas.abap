CLASS zcl_shape DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

PUBLIC SECTION.
    METHODS: constructor IMPORTING im_name TYPE string,
             add ABSTRACT IMPORTING im_shape TYPE REF TO zcl_shape,
             remove ABSTRACT IMPORTING im_shape TYPE REF TO zcl_shape,
             display ABSTRACT IMPORTING im_indent TYPE i.

PROTECTED SECTION.
    DATA: lv_name TYPE string.

PRIVATE SECTION.
ENDCLASS.



CLASS zcl_shape IMPLEMENTATION.
  METHOD constructor.
    lv_name = im_name.
  ENDMETHOD.

ENDCLASS.
