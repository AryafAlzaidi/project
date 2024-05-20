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
