import React, { useEffect, useState } from "react";
import Stepper from "../../CoreComponent/stepper";
import "./style.scss";
import FlightInformation from "./FlightInformation";
import { AdminFlightStepperProvider, useFlightStepperAdmin } from "./StepperContext";
// import CompanionInformation from "./CompanionInformation";
import { removeFromLocalStorage } from "../../common/localStorage";

const AdminFlightStepperPageContent = () => {
  const { currentStep, completedSteps, setCurrentStep, completeStep } =
    useFlightStepperAdmin();

  const stepperInfo = [
    { title: "Flight Information" },
    { title: "Companion Information" },
  ];

  const componentsMap = [<FlightInformation/>, <h1>fddd</h1>];

  useEffect(() => {
    return () => {
      removeFromLocalStorage("flightDetails");
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
        <div className="header-current-step">Tilte </div>
        <div className="current-component">{componentsMap[currentStep]}</div>
      </div>
    </div>
  );
};

const FlightStepperPageAdmin = () => (
  <AdminFlightStepperProvider>
    <AdminFlightStepperPageContent />
  </AdminFlightStepperProvider>
);

export default FlightStepperPageAdmin;
