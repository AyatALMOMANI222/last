import React, { useEffect, useState } from "react";
import Stepper from "../../CoreComponent/stepper";
import "./style.scss";
import FlightInformation from "./FlightInformation";
import {
  AdminFlightStepperProvider,
  useFlightStepperAdmin,
} from "./StepperContext";
import { removeFromLocalStorage } from "../../common/localStorage";

const AdminFlightStepperPageContent = () => {
  const {
    currentStep,
    completedSteps,
    setCurrentStep,
    completeStep,
    flightMembers,
  } = useFlightStepperAdmin();

  // Dynamically generate steps based on the number of flight members
  const stepperInfo = flightMembers?.map((member, index) => ({
    title: `${member?.passenger_name} Flight Information `,
  }));

  const componentsMap = flightMembers?.map((member, index) => (
    <FlightInformation key={index} member={member} index={index} />
  ));

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
        <div className="header-current-step">Title</div>
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
