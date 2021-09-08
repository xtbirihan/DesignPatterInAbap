*&---------------------------------------------------------------------*
*& Report zdp_dp_composite
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_dp_composite.

START-OF-SELECTION.
  DATA: lo_pic   TYPE REF TO zcl_shape,
        lo_shape TYPE REF TO zcl_shape,
        lo_pic2  TYPE REF TO zcl_shape.

  CREATE OBJECT lo_pic   TYPE zcl_picture EXPORTING im_name = 'zcl_picture'.
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Left Line'.
  lo_pic->add( lo_shape ).
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Top Line'.
  lo_pic->add( lo_shape ).
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Right Line'.
  lo_pic->add( lo_shape ).
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Bottom Line'.
  lo_pic->add( lo_shape ).

  CREATE OBJECT lo_pic2  TYPE zcl_picture EXPORTING im_name = 'zcl_picture'.
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Left Line'.
  lo_pic2->add( lo_shape ).
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Top Line'.
  lo_pic2->add( lo_shape ).
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Right Line'.
  lo_pic2->add( lo_shape ).
  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'Bottom Line'.
  lo_pic2->add( lo_shape ).
  lo_pic->add( lo_pic2 ).

  CREATE OBJECT lo_shape TYPE zcl_picture EXPORTING im_name = 'text'.
  lo_pic->add( lo_shape ).

  lo_pic->display( 1 ).
