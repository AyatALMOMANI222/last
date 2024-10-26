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
  const [includeAccommodation, setIncludeAccommodation] = useState();
  const [accommodationStars, setAccommodationStars] = useState();
  const [nightsCount, setNightsCount] = useState(3);
  const [checkInDate, setCheckInDate] = useState("");
  const [checkOutDate, setCheckOutDate] = useState("");

  const handleSubmit = (e) => {
    toast.success("The data was updated successfully!");
    const formData = {
      includeAccommodation,
      accommodationStars,
      nightsCount,
      checkInDate,
      checkOutDate,
    };
    completeStep(currentStep);
    saveToLocalStorage("AccommodationData", formData);
  };
  useEffect(() => {
    const data = getFromLocalStorage("mainRoom");
    if (data) {
      setIncludeAccommodation(data?.includeAccommodation);
      setAccommodationStars(data?.accommodationStars);
      setNightsCount(data?.nightsCount);
      setCheckInDate(data?.checkInDate);
      setCheckOutDate(data?.checkOutDate);
    }
  }, []);
  return (
    <div>
      <form className="accommodation-form-steeper">
        <div className="check-in-input-container">
          <Checkbox
            label="Include Accommodation"
            checkboxValue={includeAccommodation}
            setCheckboxValue={setIncludeAccommodation}
            icon={""}
            errorMsg={""}
            className="form-checkbox"
          />
        </div>
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
