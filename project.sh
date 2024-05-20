#!/bin/bash

flights_file="flights.txt"
bookings_file="bookings.txt"

view_flight_details() {
    flight_number=$1
    flight_info=$(grep "^$flight_number" "$flights_file")
    if [ -z "$flight_info" ]; then
        echo "Not found."
    else
        echo "Flight details:"
        echo "$flight_info"
    fi
}

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
}

cancel_booking() {

    read -p "Enter the flight number to cancel booking: " flight_number
    if ! grep -q "$flight_number" "$bookings_file"; then
        echo  "Flight is not booked before."
    else
        sed -i "/$flight_number/d" "$bookings_file"
        echo "Flight is Canceled."
    fi
}

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
}

while true; do
    echo "Hello! Welcome to the airlines, here's the services:"
    echo "1. Flights details"
    echo "2. Book flight"
    echo "3. cancel Reservation"
    echo "4. Confirm Reservation"
    echo "5. Exit"

    read -p "Please enter your choice: " choice

    case $choice in
        1) echo "Here's the available flights: "
           cat $flights_file
           read -p "Please enter flight number: " flight_number
           view_flight_details "$flight_number" ;;
        2) book_flight ;;
        3) cancel_booking ;;
        4) confirm_booking ;;
        5) exit ;;
        *) echo "Wrong number " ;;
    esac
done
