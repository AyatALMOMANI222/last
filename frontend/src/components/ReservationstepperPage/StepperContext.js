// StepperContext.js
import React, { useState, createContext, useContext } from "react";

const StepperContext = createContext();

export const StepperProvider = ({ children }) => {
  const [currentStep, setCurrentStep] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);
  const [invoice, setInvoice] = useState({});

  const completeStep = (stepIndex) => {
    if (!completedSteps.includes(stepIndex)) {
      setCompletedSteps((prev) => [...prev, stepIndex]);
    }
    setCurrentStep(stepIndex + 1);
  };

  return (
    <StepperContext.Provider
      value={{
        currentStep,
        setCurrentStep,
        completedSteps,
        completeStep,
        invoice,
        setInvoice,
      }}
    >
      {children}
    </StepperContext.Provider>
  );
};

// Custom hook to use the StepperContext
export const useStepper = () => useContext(StepperContext);
