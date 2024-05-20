cancel_booking() {

    read -p "Enter the flight number to cancel booking: " flight_number
    if ! grep -q "$flight_number" "$bookings_file"; then
        echo  "Flight is not booked before."
    else
        sed -i "/$flight_number/d" "$bookings_file"
        echo "Flight is Canceled."
    fi
}
