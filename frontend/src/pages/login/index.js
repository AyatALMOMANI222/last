import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import axiosInstance from "../../common/http";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import SVG from "react-inlinesvg";
import loginImg from "../../icons/loginImg.svg";
import { useAuth } from "../../common/AuthContext";
import { useLocation } from 'react-router-dom';

import "./style.scss";

const LoginPage = () => {
  const location = useLocation();
  const currentRoute = location.pathname;
  const { login, isAdmin } = useAuth();
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [error, setError] = useState({
    email: "",
    password: "",
    confirmPassword: "",
  });

  const submitlLogin = async () => {
    const url = `${BaseUrl}/login`;
    console.log({BaseUrl});
    
    const userData = {
      email,
      password,
    };

    try {
      const response = await axiosInstance.post(url, userData);
      const token = response.data.token;
      login(token);
      if (isAdmin) {
        navigate("/home");
      }  else {
        navigate("/sponsor/section");
      }
    } catch (error) {
      console.log(error.response?.data?.message);
      toast.error(error.response?.data?.message);
      console.error("Login error:", error);
    }
  };

  const handleLogin = (e) => {
    e.preventDefault();
    let errorEmail = "";
    let errorPassword = "";
    let errorConfirmPassword = "";
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!email) {
      errorEmail = "Please enter your email.";
    } else if (!emailRegex.test(email)) {
      errorEmail = "Please enter a valid email.";
    }

    if (!password) {
      errorPassword = "Please enter your password.";
    }
    if (!confirmPassword) {
      errorConfirmPassword = "Please enter your password.";
    }

    setError({
      email: errorEmail,
      password: errorPassword,
      confirmPassword: errorConfirmPassword,
    });

    if (email && emailRegex.test(email) && password) {
      setError({
        email: "",
        password: "",
        confirmPassword: "",
      });
      submitlLogin();
    }
  };

  return (
    <div>
      <div className="login-page-container">
        <form onSubmit={handleLogin} className="login-form">
          <div className="title">
            <span>Log in</span>
            <span
              className="sub-title"
              onClick={() => {
                navigate("/registertype");
              }}
            >
              Register
            </span>
          </div>
          <div className="note">Welcome back! Please enter your details</div>

          <div className="fields-container">
            <Input
              label={"Email"}
              placeholder={"e.g. example@example.com"}
              inputValue={email}
              setInputValue={setEmail}
              required={true}
              errorMsg={error.email}
            />
            <Input
              label={"Password"}
              placeholder={"Your password"}
              inputValue={password}
              setInputValue={setPassword}
              required={true}
              errorMsg={error.password}
              type="password"
            />
          </div>
          <div className="login-btn-container">
            <button className="login-btn" type="submit">
              Login
            </button>
          </div>
        </form>
        <SVG className="login-img" src={loginImg} />
      </div>
    </div>
  );
};

export default LoginPage;
