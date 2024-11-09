// StepperContext.js
import React, { useState, createContext, useContext, useEffect } from "react";
import httpService from "../../common/httpService";
import { useParams } from "react-router-dom";
const StepperAcceptFlightContext = createContext();

export const StepperAcceptFlightProvider = ({ children }) => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [currentStep, setCurrentStep] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);
  const [passportImage, setPassportImage] = useState(null);
  const [flightMembers, setFlightMembers] = useState([]);
  const { user_id } = useParams();
  // const user_id = 13;

  const getFlightData = async () => {
    const getAuthToken = () => localStorage.getItem("token");

    const response = await httpService({
      method: "GET",
      url: `${BaseUrl}/companion-flight/${user_id}`,
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
    <StepperAcceptFlightContext.Provider
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
    </StepperAcceptFlightContext.Provider>
  );
};

// Custom hook to use the StepperContext
export const useFlightStepperAdmin = () =>
  useContext(StepperAcceptFlightContext);
