import React from "react"; 
import SimpleLabelValue from "../../../components/SimpleLabelValue"; // Import your SimpleLabelValue component
// import MySideDrawer from "../../../CoreComponent/SideDrawer"; // Ensure the correct path to your MySideDrawer
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper"; // Ensure the correct path to your CustomFormWrapper
import MySideDrawer from "../../../CoreComponent/SideDrawer";

const ViewFormExhibitions = ({ isOpen, setIsOpen, exhibitionData }) => {
  const handleSubmit = () => {
    // Handle submit if needed
  };

  if (!exhibitionData) {
    return null; // Return null if no exhibition data is provided
  }

  return (
    <div>
        <h1>hiiiiiii</h1>
    <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
      <CustomFormWrapper
        title="Exhibition Details"
        handleSubmit={handleSubmit}
        setOpenForm={setIsOpen}
      >
        <div className="exhibition-details">
          <SimpleLabelValue label="Title" value={exhibitionData.title} />
          <SimpleLabelValue label="Description" value={exhibitionData.description} />
          <SimpleLabelValue label="Location" value={exhibitionData.location} />
          <SimpleLabelValue label="Start Date" value={new Date(exhibitionData.start_date).toLocaleDateString()} />
          <SimpleLabelValue label="End Date" value={new Date(exhibitionData.end_date).toLocaleDateString()} />
          <SimpleLabelValue label="Status" value={exhibitionData.status} />
          <img src={exhibitionData.image} alt={exhibitionData.title} className="exhibition-image" />
        </div>
        <button onClick={() => setIsOpen(false)} className="close-button">Close</button>
      </CustomFormWrapper>
    </MySideDrawer>
    </div>

  );
};

export default ViewFormExhibitions;
