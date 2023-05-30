
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for travel data table'
define view entity ZV_ATRAV_ZAK 
as select from ZRAP_ATRAV_ZAK
 {
    key travel_uuid,
    travel_id,
    agency_id,
    customer_id,
    begin_date,
    end_date,
    booking_fee,
    total_price,
    currency_code,
    description,
    overall_status,
    created_by,
    created_at,
    last_changed_by,
    last_changed_at,
    local_last_changed_at
}
