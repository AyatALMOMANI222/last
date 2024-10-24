import React, { useState } from "react";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import Input from "../../../CoreComponent/Input";
import axios from "axios";
import "./style.scss";

const AddOption = ({ isOpen, setIsOpen, tripId }) => {
  // State for all options
  const [options, setOptions] = useState([
    { optionName: "", optionDescription: "", price: 0 },
  ]);

  const handleOptionChange = (index, field, value) => {
    const newOptions = [...options];
    newOptions[index][field] = value;
    setOptions(newOptions);
  };

  const addNewOption = () => {
    setOptions([...options, { optionName: "", optionDescription: "", price: 0 }]);
  };

  const deleteOption = (index) => {
    const newOptions = options.filter((_, i) => i !== index);
    setOptions(newOptions);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("token");

    const promises = options.map(async (option) => {
      const optionData = {
        trip_id: tripId,
        option_name: option.optionName,
        option_description: option.optionDescription,
        price: option.price,
      };

      try {
        const response = await axios.post(
          "http://127.0.0.1:8000/api/additional-options",
          optionData,
          {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          }
        );
      } catch (error) {
        console.error(
          "Error adding option:",
          error.response ? error.response.data : error
        );
      }
    });

    await Promise.all(promises);
  };

  return (
    <div>
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Add Additional Option"
          handleSubmit={handleSubmit}
          setOpenForm={setIsOpen}
        >
          <form className="option-form-container">
          <button type="button" onClick={addNewOption} className="add-option-btn">
              Add New Option
            </button>
            {options.map((option, index) => (
              <div key={index} className="option-input-group">
                <Input
                  label="Option Name"
                  inputValue={option.optionName}
                  setInputValue={(value) => handleOptionChange(index, "optionName", value)}
                  placeholder="Enter option name"
                />
                <Input
                  label="Option Description"
                  inputValue={option.optionDescription}
                  setInputValue={(value) => handleOptionChange(index, "optionDescription", value)}
                  placeholder="Enter option description"
                />
                <Input
                  label="Price"
                  inputValue={option.price}
                  setInputValue={(value) => handleOptionChange(index, "price", parseFloat(value) || 0)}
                  placeholder="Enter price"
                  type="number"
                />
                {/* <button className="" type="button" onClick={() => deleteOption(index)} className="delete-option-btn">
                  Delete Option
                </button> */}
              </div>
            ))}
      
          </form>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default AddOption;
