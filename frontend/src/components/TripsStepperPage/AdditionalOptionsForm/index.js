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

const AdditionalOptionsForm = () => {
  const { currentStep, completeStep } = useTripsStepper();
  const [selectedOptions, setSelectedOptions] = useState([]);
  const options = getFromLocalStorage("additionalOptions") || [];
  const handleCheckboxChange = (id) => {
    setSelectedOptions((prev) => ({
      ...prev,
      [id]: !prev[id],
    }));
  };

  const handleSubmit = (e) => {
    toast.success("The data was updated successfully!");
    const formData = selectedOptions;
    completeStep(currentStep);
    saveToLocalStorage("AdditionalOptionsData", formData);
  };
  useEffect(() => {
    const data = getFromLocalStorage("AdditionalOptionsData");
    if (data) {
      setSelectedOptions(data);
    }
  }, []);
  return (
    <div>
      <form className="additional-options-stepper-container">
        {options?.map((option) => (
          <Checkbox
            key={option.id}
            label={`${option.option_name} - ${option.option_description} ($${option.price})`}
            checkboxValue={!!selectedOptions[option?.id]}
            setCheckboxValue={() => handleCheckboxChange(option.id)}
            required={false}
            icon={null}
          />
        ))}
      </form>

      <div className="actions-section">
        <button className="next-button" onClick={handleSubmit}>
          Next
        </button>
      </div>
    </div>
  );
};
export default AdditionalOptionsForm;
