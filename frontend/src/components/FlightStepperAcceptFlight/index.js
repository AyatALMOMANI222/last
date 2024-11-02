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

const StepperAcceptFlightPageContent = () => {
  const {
    currentStep,
    completedSteps,
    setCurrentStep,
    completeStep,
    flightMembers,
  } = useFlightStepperAdmin();

  // Dynamically generate steps based on the number of flight members
  const stepperInfo =
    [
      ...flightMembers?.map((member, index) => ({
        title: `${member?.passenger_name} Flight Information `,
      })),
      {
        title: `الفاتورة `,
      },
    ] || [];

  const componentsMap =
    [
      ...flightMembers?.map((member, index) => (
        <AcceptFlight key={index} member={member} index={index} />
      )),
      <Invoice />,
    ] || [];

  useEffect(() => {
    return () => {
      removeFromLocalStorageStartWith("Available_Trip_ID_");
    };
  }, []);

  return (
    <div className="stepper-page-container">
      <div className="stepper-section">
        <div className="back-section">Back</div>
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
