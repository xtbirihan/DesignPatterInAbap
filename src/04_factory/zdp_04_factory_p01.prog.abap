*&---------------------------------------------------------------------*
*& Report ZDP_04_FACTORY_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_04_factory_p01.

PARAMETERS:
    pa_docty TYPE vbtyp. " B quotation, C order

CLASS lcl_sales_document DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: write ABSTRACT.
ENDCLASS.

CLASS lcl_quotation DEFINITION INHERITING FROM lcl_sales_document.
  PUBLIC SECTION.
    METHODS: write REDEFINITION.
ENDCLASS.

CLASS lcl_quotation IMPLEMENTATION.
  METHOD write.
    WRITE: 'Quotation'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_order DEFINITION INHERITING FROM lcl_sales_document.
  PUBLIC SECTION .
    METHODS: write REDEFINITION.
ENDCLASS.

CLASS lcl_order IMPLEMENTATION.
  METHOD write.
    WRITE: 'Order'.
  ENDMETHOD.
ENDCLASS.

INTERFACE lif_sales_document_factory.

  METHODS: create IMPORTING im_docty      TYPE vbtyp
                  RETURNING VALUE(re_doc) TYPE REF TO lcl_sales_document.
ENDINTERFACE.

CLASS lcl_sales_document_factory  DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_sales_document_factory.
    ALIASES: create FOR lif_sales_document_factory~create.
ENDCLASS.

CLASS lcl_sales_document_factory IMPLEMENTATION.
  METHOD create.
    DATA: lo_doc TYPE REF TO lcl_sales_document.
    CASE im_docty.
      WHEN 'B'.
        CREATE OBJECT lo_doc TYPE lcl_quotation.
      WHEN 'C'.
        CREATE OBJECT lo_doc TYPE lcl_order.
      WHEN OTHERS.
        CREATE OBJECT lo_doc TYPE lcl_order.
    ENDCASE.
    re_doc = lo_doc.

  ENDMETHOD.

ENDCLASS.

DATA:
  go_doc                   TYPE REF TO lcl_sales_document,
  go_sales_document_factory TYPE REF TO lif_sales_document_factory.


START-OF-SELECTION.

  CREATE OBJECT go_sales_document_factory
    TYPE lcl_sales_document_factory.

  go_doc = go_sales_document_factory->create( pa_docty ).

  go_doc->write( ).
