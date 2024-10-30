// StepperContext.js
import React, { useState, createContext, useContext } from 'react';

const AdminFlightStepperContext = createContext();

export const AdminFlightStepperProvider = ({ children }) => {
  const [currentStep, setCurrentStep] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);
  const [passportImage, setPassportImage] = useState(null);

  const completeStep = (stepIndex) => {
    if (!completedSteps.includes(stepIndex)) {
      setCompletedSteps((prev) => [...prev, stepIndex]);
    }
    setCurrentStep(stepIndex + 1);
  };

  return (
    <AdminFlightStepperContext.Provider value={{ currentStep, setCurrentStep, completedSteps, completeStep , passportImage, setPassportImage }}>
      {children}
    </AdminFlightStepperContext.Provider>
  );
};

// Custom hook to use the StepperContext
export const useFlightStepperAdmin = () => useContext(AdminFlightStepperContext);
