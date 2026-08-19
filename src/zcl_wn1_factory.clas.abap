class ZCL_WN1_FACTORY definition
  public
  final
  create private
  global friends ZCL_WN1_FACTORY_INJECTOR .

public section.

  class-methods GET_CASH_PROVIDER
    returning
      value(R_CASH_PROVIDER) type ref to ZIF_WN1_CASH_PROVIDER .

  PROTECTED SECTION.
  PRIVATE SECTION.
    class-data GO_CASH_PROVIDER type ref to ZIF_WN1_CASH_PROVIDER.
ENDCLASS.



CLASS ZCL_WN1_FACTORY IMPLEMENTATION.

  METHOD get_cash_provider.
    IF go_cash_provider IS NOT BOUND.
      go_cash_provider = CAST ZIF_WN1_CASH_PROVIDER( NEW ZCL_WN1_CASH_PROVIDER_MANAGED( ) ).
    ENDIF.
    r_cash_provider = go_cash_provider.
  ENDMETHOD.

ENDCLASS.
