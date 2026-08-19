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

CLASS ltc_setter_injection DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_wn1_setter_injection.

    METHODS setup.
    METHODS amount_1_coin_1 FOR TESTING.
    METHODS amount_29_notes_25 FOR TESTING.

ENDCLASS.


CLASS ltc_setter_injection IMPLEMENTATION.

  METHOD setup.
    cut = NEW zcl_wn1_setter_injection( ).
    cut->set_cash_provider( NEW ltd_cash_provider_double( ) ).
  ENDMETHOD.

  METHOD amount_1_coin_1.
    cl_abap_unit_assert=>assert_equals(
      act = cut->get_amount_in_coins( 1 )
      exp = 1 ).
  ENDMETHOD.

  METHOD amount_29_notes_25.
    cl_abap_unit_assert=>assert_equals(
      act = cut->get_amount_in_notes( 29 )
      exp = 25 ).
  ENDMETHOD.

ENDCLASS.
