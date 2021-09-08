interface ZIF_CONTACT
  public .

TYPES: BEGIN OF t_info,
        phone TYPE char30,
        email TYPE string,
       END OF t_info.

    METHODS get_contact_info
       IMPORTING
            !iv_recipient TYPE char10
       RETURNING
        VALUE(rs_info) TYPE t_info.

endinterface.
