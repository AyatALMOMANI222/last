import React, { useState } from "react";
import Stepper from "../../CoreComponent/stepper";
import "./style.scss";

const ParentComponent = () => {
  const [currentStep, setCurrentStep] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);

  const stepperInfo = [
    { title: "Step 1" },
    { title: "Step 2" },
    { title: "Step 3" },
    { title: "Step 4" },
  ];

  const completeStep = (stepIndex) => {
    if (!completedSteps.includes(stepIndex)) {
      setCompletedSteps((prev) => [...prev, stepIndex]);
    }
    setCurrentStep(stepIndex + 1);
  };
  const componentsMap = [
    <h1>step1</h1>,
    <h1>step2</h1>,
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
      <div className="actions-section">
        <button
          className="next-button"
          onClick={() => completeStep(currentStep)}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default ParentComponent
