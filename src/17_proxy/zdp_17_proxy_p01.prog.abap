*&---------------------------------------------------------------------*
*& Report ZDP_17_PROXY_P01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdp_17_proxy_p01.

"Abstract interface
INTERFACE if_ticket.
  METHODS: register IMPORTING id TYPE string,
    get_train_list IMPORTING from TYPE string DEFAULT 'Beijing'.

ENDINTERFACE.

"Real implementation class-12306Official website
CLASS t12306 DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES:if_ticket.
ENDCLASS.

CLASS t12306 IMPLEMENTATION.
  METHOD if_ticket~register.
    WRITE: / 'user' , id, 'registration success'.
  ENDMETHOD.
  METHOD if_ticket~get_train_list.
    WRITE:/  from ,'All trains departing'.
  ENDMETHOD.
ENDCLASS.

"Agent-Ctrip
CLASS ctrip DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES:if_ticket.
    METHODS:set_current_location,
      constructor.

  PRIVATE SECTION.
    DATA:mo_t12306 TYPE REF TO t12306,
         mv_from   TYPE string.
ENDCLASS.
CLASS ctrip IMPLEMENTATION.
  METHOD constructor.
    mo_t12306 = NEW t12306( ).
  ENDMETHOD.
  METHOD if_ticket~register.
    WRITE:/ 'Ctrip does not support 12306 account registration'.
  ENDMETHOD.
  METHOD set_current_location.
    mv_from = 'Shenzhen'.
  ENDMETHOD.
  METHOD if_ticket~get_train_list.
    me->set_current_location( ).
    mo_t12306->if_ticket~get_train_list( mv_from ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA(lo_booking_proxy) = NEW ctrip( ).
  lo_booking_proxy->if_ticket~register( 'Zhang San').
  lo_booking_proxy->if_ticket~get_train_list( ).
