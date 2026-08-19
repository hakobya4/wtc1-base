class ZCL_WN1_SETTER_INJECTION definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR .
  methods SET_CASH_PROVIDER
    importing
      !I_CASH_PROVIDER type ref to ZIF_WN1_CASH_PROVIDER .
  methods GET_AMOUNT_IN_COINS
    importing
      !I_AMOUNT type I
    returning
      value(R_VALUE) type I .
  methods GET_AMOUNT_IN_NOTES
    importing
      !I_AMOUNT type I
    returning
      value(R_VALUE) type I .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mo_cash_provider TYPE REF TO ZIF_WN1_CASH_PROVIDER.
ENDCLASS.



CLASS ZCL_WN1_SETTER_INJECTION IMPLEMENTATION.

  METHOD constructor.
    mo_cash_provider = CAST ZIF_WN1_CASH_PROVIDER( NEW ZCL_WN1_CASH_PROVIDER( ) ).
  ENDMETHOD.

  METHOD set_cash_provider.
    mo_cash_provider = i_cash_provider.
  ENDMETHOD.

  METHOD get_amount_in_coins.
    DATA(notes) = mo_cash_provider->get_notes( i_currency = 'EUR' ).
    SORT notes BY amount ASCENDING.

    r_value = COND #( WHEN i_amount <= 0
                      THEN -1
                      ELSE i_amount MOD notes[ 1 ]-amount ).
  ENDMETHOD.

  METHOD get_amount_in_notes.
    r_value = get_amount_in_coins( i_amount ).
    IF r_value >= 0.
      r_value = i_amount - r_value.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
