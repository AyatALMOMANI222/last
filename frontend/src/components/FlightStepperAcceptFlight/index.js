import React, { useEffect, useState } from "react";
import Stepper from "../../CoreComponent/stepper";
import "./style.scss";
import AcceptFlight from "./AcceptFlight";
import {
  StepperAcceptFlightProvider,
  useFlightStepperAdmin,
} from "./StepperContext";
import {
  removeFromLocalStorage,
  removeFromLocalStorageStartWith,
} from "../../common/localStorage";
import Invoice from "./Invoice";
import { useNavigate } from "react-router-dom";

const StepperAcceptFlightPageContent = () => {
  const {
    currentStep,
    completedSteps,
    setCurrentStep,
    completeStep,
    flightMembers,
  } = useFlightStepperAdmin();
  const navigate = useNavigate();

  // Dynamically generate steps based on the number of flight members
  const stepperInfo =
    [
      ...flightMembers?.map((member, index) => ({
        title: `${member?.passenger_name} Flight Information `,
      })),
      {
        title: `Invoice `,
      },
    ] || [];

  const componentsMap =
    [
      ...flightMembers?.map((member, index) => (
        <AcceptFlight key={index} member={member} index={index} />
      )),
      <Invoice />,
    ] || [];
  const handleBackClick = () => {
    navigate(-1); // Navigates to the previous page
  };
  useEffect(() => {
    return () => {
      removeFromLocalStorageStartWith("Available_Trip_ID_");
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
        <div className="header-current-step">Title</div>
        <div className="current-component">{componentsMap[currentStep]}</div>
      </div>
    </div>
  );
};

const StepperAcceptFlight = () => (
  <StepperAcceptFlightProvider>
    <StepperAcceptFlightPageContent />
  </StepperAcceptFlightProvider>
);

export default StepperAcceptFlight;
