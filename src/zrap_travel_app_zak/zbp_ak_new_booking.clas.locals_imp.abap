CLASS lhc_ZAK_NEW_BOOKING DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zak_new_booking.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zak_new_booking.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zak_new_booking.

    METHODS read FOR READ
      IMPORTING keys FOR READ zak_new_booking RESULT result.

ENDCLASS.

CLASS lhc_ZAK_NEW_BOOKING IMPLEMENTATION.

  METHOD create.
    DATA : new_ent TYPE STANDARD TABLE OF /dmo/booking_m.

    IF entities IS NOT INITIAL.
      DATA(t_id) = entities[ 1 ]-travel_id.
      SELECT MAX(  booking_id )
       FROM /dmo/booking_m
       WHERE travel_id = @t_id
       INTO @DATA(m_b_id).
      DATA(co_id) =   entities[ 1 ]-connection_id.
      SELECT SINGLE carrier_id
      FROM /dmo/connection
      WHERE connection_id = @co_id
      INTO @DATA(c_id).
      m_b_id = m_b_id + 1 .
      new_ent = VALUE #(  FOR ent IN entities (
                          travel_id   = ent-travel_id
                          booking_id  = m_b_id
                          booking_date    = ent-booking_date
                          customer_id    = ent-customer_id
                          carrier_id      = c_id"ent-carrier_id
                          connection_id   = ent-connection_id
                          flight_date     = ent-flight_date
                          flight_price    = 400 "ent-flight_price
                          currency_code   = 'USD' "ent-currency_code
                          booking_status  = ent-booking_status
                          last_changed_at = ent-last_changed_at
      ) ).

      MODIFY /dmo/booking_m FROM TABLE @new_ent.
      APPEND VALUE #( travel_id = entities[ 1 ]-travel_id
**                      booking_id = m_b_id + 1
                          "item             = header-item
                          %msg             = new_message( id = ''
                                                           number   = '0'
                                                           severity = if_abap_behv_message=>severity-success
                                                           v1 = 'Flight Booked.  Booking Id : '
                                                           v2 =  m_b_id  )

                          ) TO reported-zak_new_booking.


    ENDIF.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZAK_NEW_BOOKING DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZAK_NEW_BOOKING IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
