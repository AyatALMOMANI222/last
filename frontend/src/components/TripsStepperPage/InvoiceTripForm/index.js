import React, { useEffect, useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import SimpleLabelValue from "../../../components/SimpleLabelValue";
import { getFromLocalStorage } from "../../../common/localStorage";
import httpService from "../../../common/httpService";
import { useNavigate, useParams } from "react-router-dom";
import "./style.scss";

const InvoiceTripForm = () => {
  const navigate = useNavigate()
  const { tripId } = useParams();
  const [basePrice, setBasePrice] = useState("");
  const [addtionalOptionsPrice, setAddtionalOptionsPrice] = useState(0);
  const participantsData = getFromLocalStorage("participants") || [];
  const additionalOptionsData = getFromLocalStorage("AdditionalOptionsData");
  const accommodationData = getFromLocalStorage("AccommodationData");
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const handleSubmit = () => {
    const token=localStorage.getItem("token")
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
  
    console.log(body);
  
    // الاتصال بالـ API
    axios.post(`${BaseUrl}/trip-participants`, body, {
      headers: {
        Authorization: `Bearer ${token}`, // إضافة التوكن هنا
        "Content-Type": "application/json", // تحديد نوع المحتوى
      },
    })
      .then((response) => {
        // التعامل مع الاستجابة هنا
        console.log(response.data);
        toast.success("The data was updated successfully!");
      })
      .catch((error) => {
        // التعامل مع الخطأ هنا
        console.error("There was an error!", error);
        toast.error("Failed to update the data.");
      });
  };
  
////////////////////////////////////
  const calculateTotalPrice = (options) => {
    return options?.reduce((total, option) => {
      if (option.value) {
        return total + parseFloat(option.price);
      }
      return total;
    }, 0);
  };

  const getAuthToken = () => localStorage.getItem("token");
  const calculatePrice = (tripType, priceOne, priceTwo, priceThree) => {
    if (tripType === "private") {
      if (participantsData.length === 0) {
        setBasePrice(Number(priceOne));
      } else if (participantsData.length === 1) {
        setBasePrice(Number(priceTwo));
      } else if (participantsData.length >= 2) {
        setBasePrice(Number(priceThree));
      }
    }
  };

  const getTripById = async (tripId) => {
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/trip_option/${tripId}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
      });
      const additionalPrice = calculateTotalPrice(additionalOptionsData);
      setAddtionalOptionsPrice(additionalPrice);
      const priceOne = Number(response?.trip?.price_per_person);
      const priceTwo = Number(response?.trip?.price_for_two);
      const priceThree = Number(response?.trip?.price_for_three_or_more);
      const tripType = response?.trip?.trip_type;
      calculatePrice(tripType, priceOne, priceTwo, priceThree);
    } catch (error) {
      console.error("Error submitting discount", error);
    }
  };

  useEffect(() => {
    getTripById(tripId);
  }, [tripId]);

  return (
    <div className="invoice-trips-container-stepper">
      {accommodationData && (
        <div>
          <div className="header-invoice-trips">Accommodation Details</div>

          <div className="accommodation-data-container">
            <SimpleLabelValue
              label="Check-in Date"
              value={accommodationData.check_in_date
              }
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
          <div className="cost-container">
            <SimpleLabelValue label="Base Cost" value={basePrice} />
            <SimpleLabelValue
              label="Aditional Options Cost"
              value={addtionalOptionsPrice}
            />
            <SimpleLabelValue
              label="Total Cost"
              value={(basePrice + addtionalOptionsPrice) * Number(accommodationData.nights_count)}
            />
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
              <div className="cost-container">
                <SimpleLabelValue label="Base Cost" value={basePrice} />
                <SimpleLabelValue
                  label="Aditional Options Cost"
                  value={addtionalOptionsPrice}
                />
                <SimpleLabelValue
                  label="Total Cost"
                  value={(basePrice + addtionalOptionsPrice)* Number(participant.nights_count)}
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
