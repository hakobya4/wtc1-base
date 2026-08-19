CLASS zcl_wn1_money_machine DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_change,
             amount TYPE i,
             type   TYPE string,
           END OF ty_change.
    TYPES tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.

    METHODS get_change
      IMPORTING
        !i_amount       TYPE i
      RETURNING
        VALUE(r_change) TYPE tt_change .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wn1_money_machine IMPLEMENTATION.



  METHOD get_change.
    TYPES: BEGIN OF ty_bill,
             value TYPE i,
             type  TYPE string,
           END OF ty_bill.
    TYPES ty_bill_tab TYPE STANDARD TABLE OF ty_bill WITH DEFAULT KEY.

    DATA remaining TYPE i.

    IF i_amount <= 0.
      RETURN.
    ENDIF.

    remaining = i_amount.

    LOOP AT VALUE ty_bill_tab(
        ( value = 500 type = 'NOTE' )
        ( value = 200 type = 'NOTE' )
        ( value = 100 type = 'NOTE' )
        ( value = 50  type = 'NOTE' )
        ( value = 20  type = 'NOTE' )
        ( value = 10  type = 'NOTE' )
        ( value = 5   type = 'NOTE' )
        ( value = 2   type = 'COIN' )
        ( value = 1   type = 'COIN' ) ) INTO DATA(bill).

      WHILE remaining >= bill-value.
        APPEND VALUE #( amount = bill-value type = bill-type ) TO r_change.
        remaining = remaining - bill-value.
      ENDWHILE.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
