CLASS zrap_generate_data_zak DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZRAP_GENERATE_DATA_ZAK IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DELETE FROM zrap_atrav_zak.
  DELETE FROM zrap_abook_zak.

  INSERT zrap_atrav_zak FROM (
   SELECT
    FROM /dmo/travel
    FIELDS
    UUID( ) as travel_uuid,
    travel_id as travel_id,
    agency_id as agency_id,
    customer_id as customer_id,
    begin_date as begin_date,
    end_date as end_date,
    booking_fee as booking_fee,
    total_price as total_price,
    currency_code as currency_code,
    description as description,
    case status
    WHEN 'B' THEN 'A'
    WHEN 'X' THEN 'X'
    ELSE 'O'
    END as overall_status,
    createdby as created_by ,
    createdat as created_at,
    lastchangedby as last_changed_by,
    lastchangedat as last_changed_at,
    lastchangedat as local_last_changed_at
    order by travel_id up to 200 rows
   ).
   commit work.

   INSERT zrap_abook_zak FROM (
   SELECT
   FROM /dmo/booking as booking
   join zrap_atrav_zak as z
   on booking~travel_id = z~travel_id
   FIELDS
   UUID(  )  as booking_uuid,
   z~travel_uuid as travel_uuid,
   booking~booking_id as booking_id,
   booking~booking_date as booking_date,
   booking~customer_id as customer_id,
   booking~carrier_id  as carrier_id ,
   booking~connection_id  as connection_id ,
   booking~flight_date  as flight_date ,
   booking~flight_price  as flight_price ,
   booking~currency_code  as currency_code ,
   z~created_by    as created_by,
   z~last_changed_by as last_changed_by,
   z~last_changed_at as local_last_changed_by

    ).
    commit work.
    out->write('Travel and Booking demo data inserted' ).

  ENDMETHOD.
ENDCLASS.
