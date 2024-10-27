import React, { useEffect, useState } from "react";
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

  const handleCheckboxChange = (option) => {
    setSelectedOptions((prev) => {
      const optionExists = prev?.find(
        (item) => item.option_name === option.option_name
      );
      if (optionExists) {
        // Remove if already selected
        return prev.filter((item) => item.option_name !== option.option_name);
      } else {
        // Add new option
        return [
          ...prev,
          {
            id: option.id,
            option_name: option.option_name,
            price: option.price,
            value: true,
          },
        ];
      }
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    toast.success("The data was updated successfully!");
    completeStep(currentStep);
    saveToLocalStorage("AdditionalOptionsData", selectedOptions);
  };

  useEffect(() => {
    const data = getFromLocalStorage("AdditionalOptionsData");
    if (Array.isArray(data)) {
      setSelectedOptions(data);
    } else {
      setSelectedOptions([]); // Ensure selectedOptions is always an array
    }
  }, []);

  return (
    <div>
      <form
        className="additional-options-stepper-container"
        onSubmit={handleSubmit}
      >
        {options?.map((option) => (
          <Checkbox
            key={option.id}
            label={`${option.option_name} ($${option.price})`}
            checkboxValue={
              !!selectedOptions?.find(
                (item) => item.option_name === option.option_name
              )
            }
            setCheckboxValue={() => handleCheckboxChange(option)}
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
