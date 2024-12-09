import React, { useEffect, useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import SimpleLabelValue from "../../../components/SimpleLabelValue";
import {
  getFromLocalStorage,
  saveToLocalStorage,
} from "../../../common/localStorage";
import httpService from "../../../common/httpService";
import { useNavigate, useParams } from "react-router-dom";
import "./style.scss";
import { useTripsStepper } from "../StepperContext";

const InvoiceTripForm = () => {
  const { currentStep, completeStep, invoice, setInvoice } = useTripsStepper();
  const navigate = useNavigate();
  const { tripId } = useParams();
  const participantsData = getFromLocalStorage("participants") || [];
  const additionalOptionsData = getFromLocalStorage("AdditionalOptionsData");
  const accommodationData = getFromLocalStorage("AccommodationData");
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const handleSubmit = () => {
    completeStep(currentStep);

    const token = localStorage.getItem("token");
    const participantsList = participantsData?.map((item) => {
      return {
        ...item,
        nationality: item?.nationality?.value,
        include_accommodation: item?.include_accommodation?.value,
        is_companion: true,
      };
    });
    const speakerData = { ...accommodationData, is_companion: false };
    const addtionalOptionsBody = additionalOptionsData.map((item) => item?.id);

    const body = {
      trip_id: tripId,
      options: addtionalOptionsBody,
      participants: [speakerData, ...participantsList],
    };

    axios
      .post(`${BaseUrl}/trip-participants`, body, {
        headers: {
          Authorization: `Bearer ${token}`, // إضافة التوكن هنا
          "Content-Type": "application/json", // تحديد نوع المحتوى
        },
      })
      .then((response) => {
        const invoiceIds = response.data?.invoice.map((item) => {
          return item.participant_id;
        });
        setInvoice(response.data?.invoice);
        saveToLocalStorage("invoiceIds", invoiceIds);
        setTimeout(() => {
          completeStep(currentStep);
        }, [1000]);

        toast.success("The data was updated successfully!");
      })
      .catch((error) => {
        setInvoice([]);
        toast.error("User is already registered in this trip");
        navigate("/view-user-trips");
      });
  };

  return (
    <div className="invoice-trips-container-stepper">
      {accommodationData && (
        <div>
          <div className="header-invoice-trips">Accommodation Details</div>

          <div className="accommodation-data-container">
            <SimpleLabelValue
              label="Check-in Date"
              value={accommodationData.check_in_date}
            />
            <SimpleLabelValue
              label="Check-out Date"
              value={accommodationData.check_out_date}
            />
            <SimpleLabelValue
              label="Accommodation Stars"
              value={accommodationData.accommodation_stars}
            />
            <SimpleLabelValue
              label="Nights Count"
              value={accommodationData.nights_count}
            />{" "}
          </div>
        </div>
      )}

      {participantsData.length > 0 && (
        <div className="participants-data-container">
          {participantsData.map((participant, index) => (
            <div key={participant.id}>
              <div className="header-invoice-trips Participants">
                Participants {index + 1}
              </div>
              <div className="participant-section">
                <SimpleLabelValue label="Name" value={participant.name} />
                <SimpleLabelValue
                  label="Nationality"
                  value={participant.nationality.label}
                />
                <SimpleLabelValue
                  label="Phone Number"
                  value={participant.phone_number}
                />
                <SimpleLabelValue
                  label="WhatsApp Number"
                  value={participant.whatsapp_number}
                />
                <SimpleLabelValue
                  label="Is Companion"
                  value={participant.is_companion ? "Yes" : "No"}
                />
                <SimpleLabelValue
                  label="Include Accommodation"
                  value={participant.include_accommodation.label}
                />
                <SimpleLabelValue
                  label="Accommodation Stars"
                  value={participant.accommodation_stars}
                />
                <SimpleLabelValue
                  label="Nights Count"
                  value={participant.nights_count}
                />
              </div>
            </div>
          ))}
        </div>
      )}

      <div className="actions-section">
        <button className="next-button" onClick={handleSubmit}>
          Next
        </button>
      </div>
    </div>
  );
};

export default InvoiceTripForm;
