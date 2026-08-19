class ZCL_WN1_PARAMETER_INJECTION definition
  public
  final
  create public .

public section.

  methods GET_AMOUNT_IN_COINS
    importing
      !I_AMOUNT type I
      !I_CASH_PROVIDER type ref to ZIF_WN1_CASH_PROVIDER
    returning
      value(R_VALUE) type I .
  methods GET_AMOUNT_IN_NOTES
    importing
      !I_AMOUNT type I
      !I_CASH_PROVIDER type ref to ZIF_WN1_CASH_PROVIDER
    returning
      value(R_VALUE) type I .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WN1_PARAMETER_INJECTION IMPLEMENTATION.


  METHOD get_amount_in_coins.
    DATA(notes) = i_cash_provider->get_notes( i_currency = 'EUR' ).
    SORT notes BY amount ASCENDING.

    r_value = COND #( WHEN i_amount <= 0
                      THEN -1
                      ELSE i_amount MOD notes[ 1 ]-amount ).
  ENDMETHOD.


  METHOD get_amount_in_notes.
    r_value = get_amount_in_coins( i_amount = i_amount i_cash_provider = i_cash_provider ).
    IF r_value >= 0.
      r_value = i_amount - r_value.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
