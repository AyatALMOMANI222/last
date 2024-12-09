import React, { useEffect, useState } from "react";
import Checkbox from "../../../CoreComponent/Checkbox";
import { toast } from "react-toastify";
import "./style.scss";
import { useTripsStepper } from "../StepperContext";
import {
  saveToLocalStorage,
  getFromLocalStorage,
} from "../../../common/localStorage";
import httpService from "../../../common/httpService";

const AdditionalOptionsForm = () => {
  const { currentStep, completeStep, tripId } = useTripsStepper();
  const [selectedOptions, setSelectedOptions] = useState([]);
  const options = getFromLocalStorage("additionalOptions") || [];
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [discountedOptions, setDiscountedOptions] = useState([]);

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
  const getDiscountOptions = async () => {
    try {
      const getAuthToken = () => localStorage.getItem("token");

      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/discount-options/${tripId}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
      });

      const discountOptions = response.data;
      const localOptions = getFromLocalStorage("additionalOptions") || [];

      // Merge base options with discount options
      const mergedOptions = localOptions.map((option) => {
        const discount = discountOptions.find((d) => d.option_id === option.id);
        return {
          ...option,
          price: discount?.price || option.price,
          isDiscounted: discount?.price === "0.00",
        };
      });

      setDiscountedOptions(
        mergedOptions.filter((option) => option.isDiscounted)
      );
    } catch (error) {
      setDiscountedOptions([]);
    }
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
  useEffect(() => {
    getDiscountOptions();
  }, []);

  return (
    <div>
      {discountedOptions.length > 0 && (
        <div className="discount-note">
          <p className="discount-title">
            <strong>Note:</strong> This discount is exclusively available for
            speakers.
          </p>
          <ul className="discount-list">
            {discountedOptions.map((option) => (
              <li key={option.id} className="discount-item">
                {option.option_name} -{" "}
                <span className="discount-price">Price: $0</span>
              </li>
            ))}
          </ul>
        </div>
      )}

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
        {!options?.length && <div>No Options Available</div>}
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
