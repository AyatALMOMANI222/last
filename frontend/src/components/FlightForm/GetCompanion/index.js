import React, { useState, useEffect } from "react";
import axios from "axios";
import SimpleLabelValue from "../../SimpleLabelValue";
import { useAuth } from "../../../common/AuthContext";

import "./style.scss";

const GetCompanion = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [companions, setCompanions] = useState([]);
  const { userId } = useAuth();

  const getCompanionData = () => {
    const token = localStorage.getItem("token");

    axios
      .get(`${BaseUrl}/companion-flight/${userId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setCompanions(response.data);
        console.log(response.data);
      })
      .catch((error) => {
        console.error("Error fetching companion data:", error);
      });
  };

  useEffect(() => {
    getCompanionData();
  }, []);

  const removeCompanion = (index) => {
    setCompanions((prevCompanions) =>
      prevCompanions.filter((_, i) => i !== index)
    );
  };

  return (
    <div className="companion-list-container">
      <div className="title-container">Companion Flight Information</div>

      {companions.length ? (
        <div className="companions-list">
          {companions.map((companion, index) => (
            <div key={index} className="companion-card">
              <button
                className="close-btn"
                onClick={() => removeCompanion(index)}
                aria-label="Remove Companion"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  viewBox="0 0 24 24"
                >
                  <line x1="18" y1="6" x2="6" y2="18"></line>
                  <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
              </button>

              <div className="companion-details">
                <div className="details-header">Flight Details</div>
                <div className="grid-container">
                  {companion.passenger_name &&
                    companion.passenger_name !== "" && (
                      <SimpleLabelValue
                        label="Passenger Name"
                        value={companion.passenger_name}
                      />
                    )}
                  {companion.flight_number &&
                    companion.flight_number !== "" &&
                    companion.flight_number !== "0" && (
                      <SimpleLabelValue
                        label="Flight Number"
                        value={companion.flight_number}
                      />
                    )}
                  {companion.departure_airport &&
                    companion.departure_airport !== "" && (
                      <SimpleLabelValue
                        label="Departure Airport"
                        value={companion.departure_airport}
                      />
                    )}
                  {companion.arrival_airport &&
                    companion.arrival_airport !== "" && (
                      <SimpleLabelValue
                        label="Arrival Airport"
                        value={companion.arrival_airport}
                      />
                    )}
                  {companion.departure_date &&
                    companion.departure_date !== "" && (
                      <SimpleLabelValue
                        label="Departure Date"
                        value={companion.departure_date}
                      />
                    )}
                  {companion.arrival_date && companion.arrival_date !== "" && (
                    <SimpleLabelValue
                      label="Arrival Date"
                      value={companion.arrival_date}
                    />
                  )}
                  {companion.upgrade_class &&
                    companion.upgrade_class !== " " &&
                    companion.upgrade_class !== "0" && (
                      <SimpleLabelValue
                        label="Upgrade Class"
                        value={companion.upgrade_class}
                      />
                    )}
                  {companion.specific_flight_time &&
                    companion.specific_flight_time !== "" &&
                    companion.specific_flight_time !== "00:00:00" && (
                      <SimpleLabelValue
                        label="Specific Flight Time"
                        value={companion.specific_flight_time}
                      />
                    )}
                  {companion.seat_preference &&
                    companion.seat_preference !== "0" &&
                    companion.seat_preference !== "0" && (
                      <SimpleLabelValue
                        label="Seat Preference"
                        value={companion.seat_preference}
                      />
                    )}
                  {companion.last_speaker_update_at &&
                    companion.last_speaker_update_at !== "" && (
                      <SimpleLabelValue
                        label="Last Speaker Update"
                        value={companion.last_speaker_update_at}
                      />
                    )}
                  {companion.last_admin_update_at &&
                    companion.last_admin_update_at !== "" && (
                      <SimpleLabelValue
                        label="Last Admin Update"
                        value={companion.last_admin_update_at}
                      />
                    )}
                </div>

                {/* Pricing Section */}
                <div className="pricing-section">
                  {companion.reserved_seat_cost > 0 ||
                  companion.business_class_upgrade_cost > 0 ||
                  companion.additional_baggage_cost > 0 ? (
                    <>
                      <div className="details-header">Pricing Details</div>
                      <div className="grid-container">
                        {companion.reserved_seat_cost > 0 && (
                          <SimpleLabelValue
                            label="Reserved Seat Cost"
                            value={`$${companion.reserved_seat_cost}`}
                          />
                        )}
                        {companion.business_class_upgrade_cost > 0 &&
                          companion.upgrade_class !== "0" && (
                            <SimpleLabelValue
                              label="Business Class Upgrade Cost"
                              value={`$${companion.business_class_upgrade_cost}`}
                            />
                          )}
                        {companion.additional_baggage_cost > 0 && (
                          <SimpleLabelValue
                            label="Additional Baggage Cost"
                            value={`$${companion.additional_baggage_cost}`}
                          />
                        )}
                      </div>
                    </>
                  ) : null}
                </div>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="no-data">No companions available</div>
      )}
    </div>
  );
};

export default GetCompanion;
