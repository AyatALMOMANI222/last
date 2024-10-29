import React, { useState } from "react";
import Stepper from "../../CoreComponent/stepper";
import "./style.scss";
import FlightInformation from "./FlightInformation";
import { FlightStepperProvider, useFlightStepper } from "./StepperContext";
import CompanionInformation from "./CompanionInformation";

const FlightStepperPageContent = () => {
  const { currentStep, completedSteps, setCurrentStep, completeStep } =
    useFlightStepper();

  const stepperInfo = [
    { title: "Step 1" },
    { title: "Step 2" },
    { title: "Step 3" },
    { title: "Step 4" },
  ];

  const componentsMap = [
    <FlightInformation />,
    <CompanionInformation />,
    <h1>step3</h1>,
    <h1>step4</h1>,
  ];
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

const FlightStepperPage = () => (
  <FlightStepperProvider>
    <FlightStepperPageContent />
  </FlightStepperProvider>
);

export default FlightStepperPage;
