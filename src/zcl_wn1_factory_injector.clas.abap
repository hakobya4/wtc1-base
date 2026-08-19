class ZCL_WN1_FACTORY_INJECTOR definition
  public
  final
  create private
  for testing .

public section.
  class-methods INJECT_CASH_PROVIDER
    importing
      !I_CASH_PROVIDER type ref to ZIF_WN1_CASH_PROVIDER .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WN1_FACTORY_INJECTOR IMPLEMENTATION.

  METHOD inject_cash_provider.
    ZCL_WN1_FACTORY=>go_cash_provider = i_cash_provider.
  ENDMETHOD.

ENDCLASS.
