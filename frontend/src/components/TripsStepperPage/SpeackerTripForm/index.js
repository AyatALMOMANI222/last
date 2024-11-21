import React, { useEffect, useState } from "react";
import Input from "../../../CoreComponent/Input";
import DateInput from "../../../CoreComponent/Date";
import Checkbox from "../../../CoreComponent/Checkbox";
import { toast } from "react-toastify";
import "./style.scss";
import { useTripsStepper } from "../StepperContext";
import {
  saveToLocalStorage,
  getFromLocalStorage,
} from "../../../common/localStorage";

const SpeackerTripForm = () => {
  const { currentStep, completeStep } = useTripsStepper();
  // const [includeAccommodation, setIncludeAccommodation] = useState(false);
  const [accommodationStars, setAccommodationStars] = useState();
  const [nightsCount, setNightsCount] = useState();
  const [checkInDate, setCheckInDate] = useState("");
  const [checkOutDate, setCheckOutDate] = useState("");

  const handleSubmit = (e) => {
    toast.success("The data was updated successfully!");

    const formData = {
      // include_accommodation: includeAccommodation,
      accommodation_stars: accommodationStars,
      nights_count: nightsCount,
      check_in_date: checkInDate,
      check_out_date: checkOutDate,
      is_companion: false,
    };
    completeStep(currentStep);
    saveToLocalStorage("AccommodationData", formData);
  };
  useEffect(() => {
    const data = getFromLocalStorage("AccommodationData");
    if (data) {
      // setIncludeAccommodation(data?.include_accommodation);
      setAccommodationStars(data?.accommodation_stars);
      setNightsCount(data?.nights_count);
      setCheckInDate(data?.check_in_date);
      setCheckOutDate(data?.check_out_date);
    }
  }, []);
  return (
    <div>
      <form className="accommodation-form-steeper">
        <Input
          label="Accommodation Stars"
          placeholder="Enter star rating (1-5)"
          inputValue={accommodationStars}
          setInputValue={setAccommodationStars}
          type="number"
          required={true}
        />

        <Input
          label="Nights Count"
          placeholder="Enter number of nights"
          inputValue={nightsCount}
          setInputValue={setNightsCount}
          type="number"
          required={true}
        />

        <DateInput
          label="Check-In Date"
          inputValue={checkInDate}
          setInputValue={setCheckInDate}
          required={true}
        />

        <DateInput
          label="Check-Out Date"
          inputValue={checkOutDate}
          setInputValue={setCheckOutDate}
          required={true}
        />
      </form>

      <div className="actions-section">
        <button className="next-button" onClick={handleSubmit}>
          Next
        </button>
      </div>
    </div>
  );
};
export default SpeackerTripForm;
