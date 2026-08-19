CLASS ltc_money_machine DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_wn1_money_machine.

    METHODS change_for_one FOR TESTING.
    METHODS change_for_four FOR TESTING.
    METHODS change_for_full_range FOR TESTING.
    METHODS change_for_error FOR TESTING.
    METHODS setup.

ENDCLASS.


CLASS ltc_money_machine IMPLEMENTATION.

  METHOD setup.
    cut = NEW zcl_wn1_money_machine( ).
  ENDMETHOD.

  METHOD change_for_one.
    DATA(result) = cut->get_change( 1 ).
    cl_abap_unit_assert=>assert_equals(
      act   = lines( result )
      exp   = 1 ).
    cl_abap_unit_assert=>assert_equals(
      act   = result[ 1 ]-amount
      exp   = 1 ).
    cl_abap_unit_assert=>assert_equals(
      act   = result[ 1 ]-type
      exp   = 'COIN' ).
  ENDMETHOD.

  METHOD change_for_four.
    DATA(result) = cut->get_change( 4 ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( result )
      exp = 2 ).

    LOOP AT result INTO DATA(line).
      cl_abap_unit_assert=>assert_equals(
        act = line-amount
        exp = 2 ).
      cl_abap_unit_assert=>assert_equals(
        act = line-type
        exp = 'COIN' ).
    ENDLOOP.
  ENDMETHOD.

  METHOD change_for_full_range.
    DATA(result) = cut->get_change( 688 ).

    DATA(expected) = VALUE zcl_wn1_money_machine=>tt_change(
        ( amount = 500 type = 'NOTE' )
        ( amount = 100 type = 'NOTE' )
        ( amount = 50  type = 'NOTE' )
        ( amount = 20  type = 'NOTE' )
        ( amount = 10  type = 'NOTE' )
        ( amount = 5   type = 'NOTE' )
        ( amount = 2   type = 'COIN' )
        ( amount = 1   type = 'COIN' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = result
      exp = expected ).
  ENDMETHOD.

  METHOD change_for_error.
    cl_abap_unit_assert=>assert_initial(
      act = cut->get_change( 0 ) ).

    cl_abap_unit_assert=>assert_initial(
      act = cut->get_change( -11 ) ).
  ENDMETHOD.
ENDCLASS.
