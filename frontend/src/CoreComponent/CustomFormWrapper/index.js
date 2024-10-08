import React from "react";
import "./style.scss";

const CustomFormWrapper = ({ title, children, handleSubmit, setOpenForm }) => {
  return (
    <form className="custom-form-wrapper" onSubmit={handleSubmit}>
      <div className="information-header">{title}</div>
      <div className="form-section">{children}</div>
      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setOpenForm(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" type="submit" onClick={handleSubmit}>
          Submit
        </button>
      </div>
    </form>
  );
};

export default CustomFormWrapper;