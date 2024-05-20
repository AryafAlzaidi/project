confirm_booking() {
    grep "This flight is not confirmed" "$bookings_file"
    read -p "Please enter flight number to confirm: " flight_number
    flight_info=$( grep "NOTCONFIRMED" "$bookings_file" |grep "$flight_number")
    if [ -z "$flight_info" ]; then
        echo "Not found."
    else
    flightbooked="${flight_info/NOTCONFIRMED/"CONFIRMED"}"
        sed  -i "s/$flight_info/$flightbooked/g" $bookings_file
        echo "Booking confirmed."
        echo "Ticket details:"
        echo "$flightbooked"
    fi
