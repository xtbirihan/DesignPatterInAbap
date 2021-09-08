CLASS zcl_line DEFINITION
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
ENDCLASS.



CLASS zcl_line IMPLEMENTATION.
  METHOD add.
    WRITE : / 'Can not add'.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( im_name = im_name ).
  ENDMETHOD.

  METHOD display.
    WRITE : /.
    DO im_indent TIMES.
      WRITE: '-'.
    ENDDO.
    WRITE: lv_name.
  ENDMETHOD.

  METHOD remove.
    WRITE : / 'Can not delete'.
  ENDMETHOD.

ENDCLASS.
