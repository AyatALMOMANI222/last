import React, { useState } from 'react';
import Select from '../../../CoreComponent/Select';
import Input from '../../../CoreComponent/Input';
import DateInput from '../../../CoreComponent/Date';
import CustomFormWrapper from '../../../CoreComponent/CustomFormWrapper';
import axios from 'axios';
import Checkbox from '../../../CoreComponent/Checkbox'; // Import your new Checkbox component
import MySideDrawer from '../../../CoreComponent/SideDrawer';

const AirportTransfer = () => {
    const [isOpen, setIsOpen] = useState(true);
    const [tripType, setTripType] = useState('One-way trip from the airport to the hotel');
    const [arrivalDate, setArrivalDate] = useState('');
    const [arrivalTime, setArrivalTime] = useState('');
    const [departureDate, setDepartureDate] = useState('');
    const [departureTime, setDepartureTime] = useState('');
    const [flightNumber, setFlightNumber] = useState('');
    const [companionName, setCompanionName] = useState('');
    const [hasCompanion, setHasCompanion] = useState(false);

    const handleSubmit = async (e) => {
        const token = localStorage.getItem("token");
        const user_id = localStorage.getItem("user_id");

        e.preventDefault();
        
        try {
            const response = await axios.post('http://127.0.0.1:8000/api/airport-transfer-bookings', {
                user_id: user_id,
                trip_type: tripType,
                arrival_date: arrivalDate,
                arrival_time: arrivalTime,
                departure_date: departureDate,
                departure_time: departureTime,
                flight_number: flightNumber,
                companion_name: hasCompanion ? companionName : null,
            }, {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            });
    
            alert('Request submitted successfully.');
            console.log(response.data);
        } catch (error) {
            alert('An error occurred while submitting the request.');
            console.log(error);
        }
    };

    return (
        <div>
            <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
                <CustomFormWrapper
                    title="Airport Transfer Request"
                    handleSubmit={handleSubmit}
                    setOpenForm={setIsOpen}
                >
                    <form className="trip-form-container">
                        <Select
                            options={[
                                { value: "One-way trip from the airport to the hotel", label: "One-way trip from the airport to the hotel" },
                                { value: "One-way trip from the hotel to the airport", label: "One-way trip from the hotel to the airport" },
                                { value: "Round trip", label: "Round trip" },
                            ]}
                            value={{ value: tripType, label: tripType }}
                            setValue={(option) => setTripType(option.value)}
                            label="Trip Type"
                            errorMsg={""}
                        />
                        
                        <DateInput
                            label="Arrival Date"
                            inputValue={arrivalDate}
                            setInputValue={setArrivalDate}
                            required={true}
                        />

                        <Input
                            label="Arrival Time"
                            inputValue={arrivalTime}
                            setInputValue={setArrivalTime}
                            placeholder="Enter Arrival Time"
                            type="time"
                            required={true}
                        />

                        <Input
                            label="Departure Date"
                            inputValue={departureDate}
                            setInputValue={setDepartureDate}
                            placeholder="Enter Departure Date"
                            type="date"
                        />

                        <Input
                            label="Departure Time"
                            inputValue={departureTime}
                            setInputValue={setDepartureTime}
                            placeholder="Enter Departure Time"
                            type="time"
                        />

                        <Input
                            label="Flight Number"
                            inputValue={flightNumber}
                            setInputValue={setFlightNumber}
                            placeholder="Enter Flight Number"
                            required={true}
                        />

                        <Checkbox
                            label="Do you have a companion?"
                            checkboxValue={hasCompanion}
                            setCheckboxValue={setHasCompanion}
                        />

                        {hasCompanion && (
                            <Input
                                label="Companion Name"
                                inputValue={companionName}
                                setInputValue={setCompanionName}
                                placeholder="Enter Companion's Name"
                            />
                        )}

                    </form>
                </CustomFormWrapper>
            </MySideDrawer>
        </div>
    );
};

export default AirportTransfer;
