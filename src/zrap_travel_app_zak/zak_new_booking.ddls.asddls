@EndUserText.label: 'New booking'
define root custom entity ZAK_NEW_BOOKING
{
  key travel_id        : /dmo/travel_id;
      booking_id       : /dmo/booking_id;
      booking_date    : /dmo/booking_date;
      customer_id     : /dmo/customer_id;
      carrier_id      : /dmo/carrier_id;
      connection_id   : /dmo/connection_id;
      flight_date     : /dmo/flight_date;
      booking_status  : /dmo/booking_status;
      last_changed_at : abp_locinst_lastchange_tstmpl;

}
