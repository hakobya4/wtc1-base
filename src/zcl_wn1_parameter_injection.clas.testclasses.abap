CLASS ltd_cash_provider_double DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES zif_wn1_cash_provider.
ENDCLASS.

CLASS ltd_cash_provider_double IMPLEMENTATION.
  METHOD zif_wn1_cash_provider~get_notes.
    r_change = VALUE #( ( amount = 5 type = 'NOTE' ) ).
  ENDMETHOD.
  METHOD zif_wn1_cash_provider~get_coins.
    " unused
  ENDMETHOD.
ENDCLASS.


CLASS ltc_parameter_injection DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_wn1_parameter_injection.
    DATA cash_provider TYPE REF TO zif_wn1_cash_provider.

    METHODS setup.
    METHODS amount_1_coin_1 FOR TESTING.
    METHODS amount_29_notes_25 FOR TESTING.

ENDCLASS.


CLASS ltc_parameter_injection IMPLEMENTATION.

  METHOD setup.
    cut = NEW zcl_wn1_parameter_injection( ).
    cash_provider = NEW ltd_cash_provider_double( ).
  ENDMETHOD.

  METHOD amount_1_coin_1.
    cl_abap_unit_assert=>assert_equals(
      act = cut->get_amount_in_coins( i_amount = 1 i_cash_provider = cash_provider )
      exp = 1 ).
  ENDMETHOD.

  METHOD amount_29_notes_25.
    cl_abap_unit_assert=>assert_equals(
      act = cut->get_amount_in_notes( i_amount = 29 i_cash_provider = cash_provider )
      exp = 25 ).
  ENDMETHOD.

ENDCLASS.
