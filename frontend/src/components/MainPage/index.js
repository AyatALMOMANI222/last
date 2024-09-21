import React, { Fragment, createContext, useEffect, useState } from "react";
import SideDrawer from "../SideDrawer";
import SVG from "react-inlinesvg";
import { modules } from "../../constant/modules";
import "./style.scss";
import Header from "../Header";
import { arrowBottom } from "../../icons";
import Input from "../../CoreComponent/Input";
import Select from "../../CoreComponent/Select";
import ImageUpload from "../../CoreComponent/ImageUpload";
import CircularCheckbox from "../../CoreComponent/CircularCheckbox";

const MyComponent = () => {
  const [selectedOption, setSelectedOption] = useState("");
  const [errorMsg, setErrorMsg] = useState("");

  // Define your options for the dropdown
  const options = [
    { value: "option1", label: "Option 1" },
    { value: "option2", label: "Option 2" },
    { value: "option3", label: "Option 3" },
  ];

  return (
    <Fragment>
      <Select
        options={options}
        value={selectedOption}
        setValue={setSelectedOption}
        // errorMsg={"erooooooooooooooor"}
        label="Select an option"
        required={true}
      />
    </Fragment>
  );
};

export const UserContext = createContext();
const MainPage = () => {
  const [isExpand, setIsExpand] = useState(false);
  const [inputValue, setInputValue] = useState("");
  const [imageData, setImageData] = useState("");


  return (
    <div id="main-page-container" className="main-page-container">
      <SideDrawer
        items={modules}
        isExpand={isExpand}
        setIsExpand={setIsExpand}
      />
      <div className="main-container">
        <Header isExpand={isExpand} setIsExpand={setIsExpand} />
        <div className="main">
          <Input
            lable={"Full Name"}
            placeholder={"e.g. hedaya almomani"}
            inputValue={inputValue}
            setInputValue={setInputValue}
            icon={arrowBottom}
          />
          <MyComponent />
          <ImageUpload
            label="Upload Image"
            allowedExtensions={["jpg", "jpeg", "png", "gif"]}
            inputValue={imageData}
            setInputValue={setImageData}
          />
          {/* <CircularCheckbox/> */}
        </div>
      </div>
    </div>
  );
};

export default MainPage;
