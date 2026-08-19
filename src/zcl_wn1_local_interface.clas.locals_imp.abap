INTERFACE lif_cash_provider.
  TYPES: BEGIN OF ty_change,
           amount TYPE i,
           type   TYPE string,
         END OF ty_change.
  TYPES tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.

  METHODS get_notes
    IMPORTING i_currency TYPE string
    RETURNING VALUE(r_change) TYPE tt_change.
ENDINTERFACE.

CLASS lcl_cash_provider_adapter DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_cash_provider.
ENDCLASS.

CLASS lcl_cash_provider_adapter IMPLEMENTATION.
  METHOD lif_cash_provider~get_notes.
    r_change = ZCL_WN1_CASH_PROVIDER_STATIC=>get_notes( i_currency = i_currency ).
  ENDMETHOD.
ENDCLASS.
