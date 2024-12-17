import React, { useEffect, useState } from "react";
import Stepper from "../../CoreComponent/stepper";
import "./style.scss";
import { TripsStepperProvider, useTripsStepper } from "./StepperContext";
import SpeackerTripForm from "./SpeackerTripForm/index";
import ParticipantTripForm from "./ParticipantTripForm";
import AdditionalOptionsForm from "./AdditionalOptionsForm";
import { removeFromLocalStorage } from "../../common/localStorage";
import InvoiceTripForm from "./InvoiceTripForm";
import PayForm from "./PayForm";
import { useNavigate } from "react-router-dom";

const TripsStepperPageContent = () => {
  const { currentStep, completedSteps, setCurrentStep, completeStep } =
    useTripsStepper();
    const navigate = useNavigate();

  const stepperInfo = [
    { title: "Accommodation Details" },
    { title: "Participant Details" },
    { title: "Additional Options Details" },
    { title: "Invoice" },
    { title: "Pay Form" },
  ];

  const componentsMap = [
    <SpeackerTripForm />,
    <ParticipantTripForm />,
    <AdditionalOptionsForm />,
    <InvoiceTripForm />,
    <PayForm />,
  ];
  const handleBackClick = () => {
    navigate(-1); // Navigates to the previous page
  };
  useEffect(() => {
    return () => {
      removeFromLocalStorage("additionalOptions");
      removeFromLocalStorage("AdditionalOptionsData");
      removeFromLocalStorage("participants");
      removeFromLocalStorage("AccommodationData");
      removeFromLocalStorage("invoiceIds");
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
