import React, { useEffect, useState } from "react";
import "./style.scss";
import Slider from "../../../Slider";
import httpService from "../../../../common/httpService";
import { useParams } from "react-router-dom";
import { backendUrlImages } from "../../../../constant/config";
// Example usage of the component
const trip = {
  id: 12,
  trip_type: "group",
  name: "Trip to the Mountains",
  description: "An amazing trip to the beautiful mountains.",
  image_1: "trip_images/y5IOt8nhcVuGdp90B90wQgKqm9Rhm2Ls1T4js8wv.jpg",
  image_2: "trip_images/bNj0oCMxQMAisafnciNMmsxLYA3cJXbtX2UXsqT3.jpg",
  image_3: "trip_images/XQl26Z5yryLjAJIhHUMmCY2w7dpTTj4VT3DH9o5d.jpg",
  image_4: "trip_images/jsvLuEkI17Pat7REASfirEsC9FlOvIdh2BJfZiVf.jpg",
  image_5: "trip_images/P7HJVu5qcPmsGUXHDwB4bwTtppOLu4gLalbbsMOa.jpg",
  price_per_person: "1000.00",
  price_for_two: "999.00",
  price_for_three_or_more: "111.00",
  available_dates: null,
  location: null,
  duration: null,
  inclusions: null,
  group_price_per_person: null,
  group_price_per_speaker: null,
  trip_details: null,
  created_at: "2024-10-08T05:57:57.000000Z",
  updated_at: "2024-10-10T05:36:06.000000Z",
};
const ViewOneTripUser = () => {
  const { id } = useParams();
  const [tripData, setTripData] = useState({});
  const [openRegisterForm, setOpenRegisterForm] = useState(false);
  const getAuthToken = () => localStorage.getItem("token");

  const getTripById = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `http://127.0.0.1:8000/api/trip_option/${id}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },

        showLoader: true,
      });

      console.log(response?.trip);
      setTripData(response?.trip);
    } catch (error) {
      console.error("Error submitting discount", error);
    }
  };
  useEffect(() => {
    getTripById();
  }, []);
  return (
    <div className="view-one-trip-for-user">
      <div className="slider">
        <Slider
          slides={[
            <img
              src={`${backendUrlImages}${trip.image_1}`}
              alt="Trip Image 1"
            />,
            <img
              src={`${backendUrlImages}${trip.image_2}`}
              alt="Trip Image 2"
            />,
            <img
              src={`${backendUrlImages}${trip.image_3}`}
              alt="Trip Image 3"
            />,
            <img
              src={`${backendUrlImages}${trip.image_4}`}
              alt="Trip Image 4"
            />,
            <img
              src={`${backendUrlImages}${trip.image_5}`}
              alt="Trip Image 5"
            />,
          ]}
        />
      </div>
      <div>
        <h1>{tripData?.name}</h1>
        <p>{tripData?.description}</p>
        <h3>Price Information</h3>
        <ul>
          <li>Price per person: ${tripData?.price_per_person}</li>
          <li>Price for two: ${tripData?.price_for_two}</li>
          <li>Price for three or more: ${tripData?.price_for_three_or_more}</li>
        </ul>
        {tripData?.additional_options?.map((item) => {
          return (
            <div>
              <div>{item?.option_name}</div>
              <div>{`Price : ${item?.price}$`} </div>
            </div>
          );
        })}
        <button className="register-trip-btn"
        onClick={()=>{
            setOpenRegisterForm(true)
        }}>Register now</button>
      </div>
    </div>
  );
};

export default ViewOneTripUser;
