CLASS ltc_roman_converter DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_wn1_roman_converter.

    METHODS setup.
    METHODS single_digit FOR TESTING.
    METHODS convert_roman FOR TESTING.
    METHODS error_convert FOR TESTING.

ENDCLASS.


CLASS ltc_roman_converter IMPLEMENTATION.

  METHOD setup.
    cut = NEW zcl_wn1_roman_converter( ).
  ENDMETHOD.

  METHOD single_digit.
    DATA(result) = cut->to_arabic( 'I' ).
    cl_abap_unit_assert=>assert_equals(
      act = result
      exp = 1
      msg = 'Single I should convert to 1' ).
  ENDMETHOD.

  METHOD convert_roman.
    cl_abap_unit_assert=>assert_equals(
      act = cut->to_arabic( 'IV' )
      exp = 4 ).

    cl_abap_unit_assert=>assert_equals(
      act = cut->to_arabic( 'IX' )
      exp = 9 ).

    cl_abap_unit_assert=>assert_equals(
      act = cut->to_arabic( 'MCMXCIV' )
      exp = 1994 ).
  ENDMETHOD.

  METHOD error_convert.
    cl_abap_unit_assert=>assert_equals(
      act = cut->to_arabic( 'IIII' )
      exp = -1 ).
    cl_abap_unit_assert=>assert_equals(
      act = cut->to_arabic( 'IL' )
      exp = -1 ).

  ENDMETHOD.

ENDCLASS.
