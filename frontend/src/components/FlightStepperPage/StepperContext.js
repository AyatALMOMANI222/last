// StepperContext.js
import React, { useState, createContext, useContext } from 'react';

const FlightStepperContext = createContext();

export const FlightStepperProvider = ({ children }) => {
  const [currentStep, setCurrentStep] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);

  const completeStep = (stepIndex) => {
    if (!completedSteps.includes(stepIndex)) {
      setCompletedSteps((prev) => [...prev, stepIndex]);
    }
    setCurrentStep(stepIndex + 1);
  };

  return (
    <FlightStepperContext.Provider value={{ currentStep, setCurrentStep, completedSteps, completeStep }}>
      {children}
    </FlightStepperContext.Provider>
  );
};

// Custom hook to use the StepperContext
export const useFlightStepper = () => useContext(FlightStepperContext);
