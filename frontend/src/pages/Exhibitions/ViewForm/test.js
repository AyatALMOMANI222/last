import React from "react";

const ViewFormExhibitions = ({ isOpen, setIsOpen }) => {
  const handleSubmit = () => {};
  return (
    <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
      <CustomFormWrapper
        title="Airport Transfer Request"
        handleSubmit={handleSubmit}
        setOpenForm={setIsOpen}
      ></CustomFormWrapper>
    </MySideDrawer>
  );
};

export default ViewFormExhibitions