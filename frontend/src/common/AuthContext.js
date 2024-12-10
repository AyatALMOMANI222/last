import React, { createContext, useContext, useState, useEffect } from "react";
import axios from "axios";
import httpService from "./httpService";

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const [authData, setAuthData] = useState({
    token: null,
    userId: null,
    userImage: null,
    myConferenceId: null,
    myConferenceName: null,
    registrationType: null,
    isAdmin: null,
    speakerData: null,
    attendancesData: null,
    loading: true,
    name: "",
    isLoggedIn: false,
  });
  useEffect(() => {
    console.log( authData?.isLoggedIn );
  }, [authData]);

  useEffect(() => {
    const savedToken = localStorage.getItem("token");
    if (savedToken) {
      setAuthData((prevState) => ({ ...prevState, token: savedToken }));
      fetchUserData(savedToken);
    } else {
      setAuthData((prevState) => ({ ...prevState, loading: false }));
    }
  }, []);

  const fetchSpeakerData = async (authToken) => {
    try {
      const response = await axios.get(`${BaseUrl}/speakers/info`, {
        headers: {
          Authorization: `Bearer ${authToken}`,
        },
      });

      setAuthData((prevState) => ({
        ...prevState,
        speakerData: response.data,
      }));
    } catch (error) {
      console.error("Failed to fetch speaker data:", error);
    }
  };

  const fetchAttendancesData = async (authToken) => {
    try {
      const response = await axios.get(`${BaseUrl}/attendances`, {
        headers: {
          Authorization: `Bearer ${authToken}`,
        },
      });
      setAuthData((prevState) => ({
        ...prevState,
        attendancesData: response.data,
      }));
    } catch (error) {
      console.error("Failed to fetch speaker data:", error);
    }
  };
  const fetchUserData = async (authToken) => {
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/user`,
        headers: {
          Authorization: `Bearer ${authToken}`,
        },
        showLoader: true,
        onSuccess:async (response) =>{
          
          const userData = response.user;
          console.log({ userData });
    
          if (userData?.registration_type === "speaker") {
            await fetchSpeakerData(authToken);
          } else if (userData?.registration_type === "attendance") {
            fetchAttendancesData(authToken);
          }
    
          setAuthData((prevState) => ({
            ...prevState,
            userId: userData.id,
            userName: userData.name,
            userImage: userData.image,
            myConferenceId: userData.conferences?.[0]?.id || null,
            myConferenceName: userData.conferences?.[0]?.title || null,
            registrationType: userData?.registration_type,
            isAdmin: userData?.isAdmin,
            loading: false,
            isLoggedIn: true,
          }));
        },
        onError: (error) => console.error("Failed to fetch user data:", error),
      });
  

    } catch (error) {
      console.error("Failed to fetch user data:", error);
    }
  };
  // const fetchUserData = async (authToken) => {
  //   try {
  //     const response = await axios.get(`${BaseUrl}/user`, {
  //       headers: {
  //         Authorization: `Bearer ${authToken}`,
  //       },
  //     });

  //     const userData = response.data.user;
  //     console.log({ userData });

  //     if (userData?.registration_type === "speaker") {
  //       await fetchSpeakerData(authToken);
  //     } else if (userData?.registration_type === "attendance") {
  //       fetchAttendancesData(authToken);
  //     }

  //     setAuthData((prevState) => ({
  //       ...prevState,
  //       userId: userData.id,
  //       userName: userData.name,
  //       userImage: userData.image,
  //       myConferenceId: userData.conferences?.[0]?.id || null,
  //       myConferenceName: userData.conferences?.[0]?.title || null,
  //       registrationType: userData?.registration_type,
  //       isAdmin: userData?.isAdmin,
  //       loading: false,
  //       isLoggedIn: true,
  //     }));
  //   } catch (error) {
  //     console.error("Failed to fetch user data:", error);
  //   }
  // };

  const login = (newToken) => {
    setAuthData((prevState) => ({
      ...prevState,
      token: newToken,
      isLoggedIn: true,
    }));
    localStorage.setItem("token", newToken);
    fetchUserData(newToken);
  };

  const logout = () => {
    setAuthData({
      token: null,
      userId: null,
      userImage: null,
      myConferenceId: null,
      myConferenceName: null,
      registrationType: null,
      isAdmin: null,
      speakerData: null,
      attendancesData: null,
      loading: false,
      name: "",
      isLoggedIn: true,
      isLoggedIn: false,
    });
    localStorage.removeItem("token");
  };

  return (
    <AuthContext.Provider
      value={{
        ...authData,
        logout,
        login,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
