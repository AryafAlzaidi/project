book_flight() {
    read -p "Please enter the flight number you want to book: " flight_number
    if ! grep -q "^$flight_number" "$flights_file"; then
        echo "Flight number does not exist."
    else
        read -p "Enter your name: " username
        read -p  "Enter your phone number: " phone
        if [ -e "$bookings_file" ]; then
            echo -e "$username - $phone - $flight_number - NOTCONFIRMED\n" >> "$bookings_file"
            echo "Flight Booked Successfully"
        else
            echo "File NOT FOUND ."
        fi
    fi
