import React, { useEffect, useState } from "react";
import Stepper from "../../CoreComponent/stepper";
import "./style.scss";
import { TripsStepperProvider, useTripsStepper } from "./StepperContext";
import SpeackerTripForm from "./SpeackerTripForm/index";
import ParticipantTripForm from "./ParticipantTripForm";
import AdditionalOptionsForm from "./AdditionalOptionsForm";
import { removeFromLocalStorage } from "../../common/localStorage";
import InvoiceTripForm from "./InvoiceTripForm";

const TripsStepperPageContent = () => {
  const { currentStep, completedSteps, setCurrentStep, completeStep } =
    useTripsStepper();

  const stepperInfo = [
    { title: "Accommodation Details" },
    { title: "Participant Details" },
    { title: "Additional Options Details" },
    { title: "Step 4" },
  ];

  const componentsMap = [
    <SpeackerTripForm />,
    <ParticipantTripForm />,
    <AdditionalOptionsForm />,
    <InvoiceTripForm />,
  ];

  useEffect(() => {
    return () => {
      // removeFromLocalStorage("additionalOptions");
      // removeFromLocalStorage("AdditionalOptionsData");
      // removeFromLocalStorage("participants");
      // removeFromLocalStorage("AccommodationData");
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
        <div className="header-current-step">Trips Form </div>
        <div className="current-component">{componentsMap[currentStep]}</div>
      </div>
    </div>
  );
};

const TripsStepperPage = () => (
  <TripsStepperProvider>
    <TripsStepperPageContent />
  </TripsStepperProvider>
);

export default TripsStepperPage;
