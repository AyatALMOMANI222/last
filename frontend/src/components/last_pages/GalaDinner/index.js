import React, { useState } from 'react';
import axios from 'axios';
import Input from '../../../CoreComponent/Input'; 
import DateInput from '../../../CoreComponent/Date'; 
import CustomFormWrapper from '../../../CoreComponent/CustomFormWrapper';
import MySideDrawer from '../../../CoreComponent/SideDrawer';

const GalaDinner = ({ isOpen, setIsOpen }) => {
    // Defining the state variables
    const [dinnerDate, setDinnerDate] = useState('');
    const [restaurantName, setRestaurantName] = useState('');
    const [location, setLocation] = useState('');
    const [gatheringPlace, setGatheringPlace] = useState('');
    const [transportationMethod, setTransportationMethod] = useState('');
    const [gatheringTime, setGatheringTime] = useState('');
    const [dinnerTime, setDinnerTime] = useState('');
    const [duration, setDuration] = useState('');
    const [dressCode, setDressCode] = useState(''); 
    const [hasCompanion, setHasCompanion] = useState(false);

    const handleSubmit = async (e) => {
        e.preventDefault();

        const dinnerDetails = {
            conference_id: 19,
            dinner_date: dinnerDate,
            restaurant_name: restaurantName,
            location,
            gathering_place: gatheringPlace,
            transportation_method: transportationMethod,
            gathering_time: gatheringTime,
            dinner_time: dinnerTime,
            duration: parseInt(duration), 
            dress_code: dressCode,
        };

        const token = localStorage.getItem('token'); 

        try {
            const response = await axios.post('http://127.0.0.1:8000/api/dinner-details', dinnerDetails, {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            });
            console.log('Response:', response.data);
        } catch (error) {
            console.error('There was an error submitting the dinner details!', error);
        }
    };

    return (
        <MySideDrawer isOpen={isOpen} onClose={() => setIsOpen(false)}> {/* SideDrawer Wrapper */}
            <CustomFormWrapper
                title="Gala Dinner Details"
                handleSubmit={handleSubmit}
                setOpenForm={setIsOpen}
            >
                <form className="trip-form-container">
                    <DateInput
                        label="Dinner Date"
                        inputValue={dinnerDate}
                        setInputValue={setDinnerDate}
                        required={true}
                    />
                    <Input
                        label="Restaurant Name"
                        inputValue={restaurantName}
                        setInputValue={setRestaurantName}
                        placeholder="Enter Restaurant Name"
                        required={true}
                    />
                    <Input
                        label="Location"
                        inputValue={location}
                        setInputValue={setLocation}
                        placeholder="Enter Location"
                    />
                    <Input
                        label="Gathering Place"
                        inputValue={gatheringPlace}
                        setInputValue={setGatheringPlace}
                        placeholder="Enter Gathering Place"
                    />
                    <Input
                        label="Transportation Method"
                        inputValue={transportationMethod}
                        setInputValue={setTransportationMethod}
                        placeholder="Enter Transportation Method"
                    />
                    <Input
                        label="Gathering Time"
                        inputValue={gatheringTime}
                        setInputValue={setGatheringTime}
                        type="time"
                        required={true}
                    />
                    <Input
                        label="Dinner Time"
                        inputValue={dinnerTime}
                        setInputValue={setDinnerTime}
                        type="time"
                        required={true}
                    />
                    <Input
                        label="Duration (minutes)"
                        inputValue={duration}
                        setInputValue={setDuration}
                        type="number"
                        placeholder="Enter Duration"
                    />
                    <Input
                        label="Dress Code"
                        inputValue={dressCode}
                        setInputValue={setDressCode}
                        placeholder="Enter Dress Code"
                    />
                </form>
            </CustomFormWrapper>
        </MySideDrawer>
    );
};

export default GalaDinner;
