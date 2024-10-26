// TripsStepperContext.js
import React, { useState, createContext, useContext, useEffect } from "react";
import httpService from "../../common/httpService";
import { useParams } from "react-router-dom";
import { saveToLocalStorage } from "../../common/localStorage";
const TripsStepperContext = createContext();

export const TripsStepperProvider = ({ children }) => {
  const [currentStep, setCurrentStep] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);
  const { tripId } = useParams();

  const completeStep = (stepIndex) => {
    if (!completedSteps.includes(stepIndex)) {
      setCompletedSteps((prev) => [...prev, stepIndex]);
    }
    setCurrentStep(stepIndex + 1);
  };
  const getAuthToken = () => localStorage.getItem("token");

  const getTripById = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `http://127.0.0.1:8000/api/trip_option/${tripId}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },

        showLoader: true,
      });
      saveToLocalStorage(
        "additionalOptions",
        response?.trip?.additional_options
      );
    } catch (error) {
      console.error("Error submitting discount", error);
    }
  };
  useEffect(() => {
    getTripById();
  }, []);
  return (
    <TripsStepperContext.Provider
      value={{ currentStep, setCurrentStep, completedSteps, completeStep }}
    >
      {children}
    </TripsStepperContext.Provider>
  );
};

// Custom hook to use the TripsStepperContext
export const useTripsStepper = () => useContext(TripsStepperContext);
