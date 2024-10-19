import React from "react";
import SimpleLabelValue from "../../../components/SimpleLabelValue";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper"; 
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import "./style.scss";
import { backendUrlImages } from "../../../constant/config";
const ViewFormExhibitions = ({ isOpen, setIsOpen, exhibitionData }) => {
  return (
    <div>
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Exhibition Details"
          setOpenForm={setIsOpen}
          noActions={true}
        >
          <div className="exhibition-details-section">
            <SimpleLabelValue label="Title" value={exhibitionData?.title} />
            <SimpleLabelValue
              label="Description"
              value={exhibitionData?.description}
            />
            <SimpleLabelValue
              label="Location"
              value={exhibitionData?.location}
            />
            <SimpleLabelValue
              label="Start Date"
              value={new Date(exhibitionData?.start_date).toLocaleDateString()}
            />
            <SimpleLabelValue
              label="End Date"
              value={new Date(exhibitionData?.end_date).toLocaleDateString()}
            />
            <SimpleLabelValue label="Status" value={exhibitionData?.status} />

            <SimpleLabelValue
              label="Exhibition Image"
              value={
                <img
                  src={`${backendUrlImages}${exhibitionData?.image}`}
                  alt={exhibitionData?.title}
                  className="view-exhibition-image"
                />
              }
            />
          </div>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default ViewFormExhibitions;
