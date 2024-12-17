import React, { useEffect } from "react";
import Stepper from "../../CoreComponent/stepper";
import ReservationForm from "./ReservationForm/index";
import { StepperProvider, useStepper } from "./StepperContext";
import RoomForm from "./RoomForm";
import InvoiceForm from "./InvoiceForm";
import "./style.scss";
import PayForm from "./PayForm";
import { useNavigate } from "react-router-dom";

export const saveToLocalStorage = (key, value) => {
  try {
    const serializedValue = JSON.stringify(value);
    localStorage.setItem(key, serializedValue);
  } catch (error) {
    console.error("Error saving to localStorage", error);
  }
};

export const getFromLocalStorage = (key) => {
  try {
    const serializedValue = localStorage.getItem(key);
    return serializedValue ? JSON.parse(serializedValue) : null;
  } catch (error) {
    console.error("Error retrieving from localStorage", error);
    return null;
  }
};

export const removeFromLocalStorage = (key) => {
  try {
    localStorage.removeItem(key);
  } catch (error) {
    console.error("Error removing from localStorage", error);
  }
};

const ParentComponentContent = () => {
  const { currentStep, completedSteps, setCurrentStep, completeStep } =
    useStepper();
    const navigate = useNavigate();

  const stepperInfo = [
    { title: "Speaker Reservation" },
    { title: "Reservation Of Companions" },
    { title: "Reservation Details" },
    { title: "Invoice" },
  ];

  const componentsMap = [
    <ReservationForm />,
    <RoomForm />,
    <InvoiceForm />,
    <PayForm />,
  ];
  const handleBackClick = () => {
    navigate(-1); // Navigates to the previous page
  };
  useEffect(() => {
    return () => {
      removeFromLocalStorage("mainRoom");
      removeFromLocalStorage("otherRooms");
    };
  }, []);

  return (
    <div className="stepper-page-container">
      <div className="stepper-section">
                <div className="back-section" onClick={handleBackClick}>
          <span className="icon">🔙</span> {/* Example icon */}
          <span className="label">Back</span>
        </div>
        <div className="stepper-container-section">
          <Stepper
            stepperInfo={stepperInfo}
            completedSteps={completedSteps}
            currentStep={currentStep}
            setCurrentStep={setCurrentStep}
            className="customStepper"
            direction="vertical"
            stepsGap="20px"
          />
        </div>
      </div>
      <div className="current-step">
        <div className="header-current-step">Reservation Form</div>
        <div className="current-component">{componentsMap[currentStep]}</div>
      </div>
    </div>
  );
};

const ParentComponent = () => (
  <StepperProvider>
    <ParentComponentContent />
  </StepperProvider>
);

export default ParentComponent;
