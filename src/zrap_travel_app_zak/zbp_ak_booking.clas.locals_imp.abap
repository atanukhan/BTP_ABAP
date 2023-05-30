CLASS lhc_zak_booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zak_booking.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zak_booking.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zak_booking.

    METHODS read FOR READ
      IMPORTING keys FOR READ zak_booking RESULT result.

ENDCLASS.

CLASS lhc_zak_booking IMPLEMENTATION.

  METHOD create.
  if entities is not Initial .
    data(info) = entities[ 1 ].
    SELECT *
    FROM /dmo/booking_m
    WHERE travel_id = @info-TravelID
      and booking_id = @info-BookingID
      into table @data(bookings).
      if sy-subrc = 0.
        bookings[ 1 ]-booking_status = info-booking_status.
        MODIFY /dmo/booking_m FROM TABLE @bookings.
        else.
*        clear entities.
APPEND VALUE #( travelid = info-TravelID
                bookingid = info-bookingid
                      "item             = header-item
                      "%msg             = message( 'Error')
                      ) TO failed-zak_booking.
      endif.
  endif.
  ENDMETHOD.

  METHOD update.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZAK_BOOKING DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZAK_BOOKING IMPLEMENTATION.

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
