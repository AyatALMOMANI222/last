// StepperContext.js
import React, { useState, createContext, useContext, useEffect } from "react";
import httpService from "../../common/httpService";
import { useParams } from "react-router-dom";
const AdminFlightStepperContext = createContext();

export const AdminFlightStepperProvider = ({ children }) => {
  const [currentStep, setCurrentStep] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);
  const [passportImage, setPassportImage] = useState(null);
  const [flightMembers, setFlightMembers] = useState([]);
  const { user_id } = useParams();

  const getFlightData = async () => {
    const getAuthToken = () => localStorage.getItem("token");

    const response = await httpService({
      method: "GET",
      url: `http://127.0.0.1:8000/api/companion-flight/${user_id}`,
      headers: { Authorization: `Bearer ${getAuthToken()}` },
    });
    setFlightMembers(response);
  };
  const completeStep = (stepIndex) => {
    if (!completedSteps.includes(stepIndex)) {
      setCompletedSteps((prev) => [...prev, stepIndex]);
    }
    setCurrentStep(stepIndex + 1);
  };

  useEffect(() => {
    getFlightData();
  }, []);

  return (
    <AdminFlightStepperContext.Provider
      value={{
        currentStep,
        setCurrentStep,
        completedSteps,
        completeStep,
        passportImage,
        setPassportImage,
        flightMembers,
      }}
    >
      {children}
    </AdminFlightStepperContext.Provider>
  );
};

// Custom hook to use the StepperContext
export const useFlightStepperAdmin = () =>
  useContext(AdminFlightStepperContext);