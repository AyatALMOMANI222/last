import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import axiosInstance from "../../common/http";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import SVG from "react-inlinesvg";
import loginImg from "../../icons/loginImg.svg";
import "./style.scss";

const LoginPage = () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState({
    email: "",
    password: "",
    confirmPassword: "",
  });

  const login = async () => {
    const url = "/user/login";
    const userData = {
      email,
      password,
    };

    try {
      const response = await axiosInstance.post(url, userData);
      toast.success(response?.data?.message);

      if (response.data.message === "Login Successfully") {
        // Navigate to the desired page on successful login
      }
    } catch (error) {
      console.error("Login error:", error);
      toast.error(error.response.data.message);
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
      login();
    }
  };

  return (
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
          <Input
            label={"Confirm Password"}
            placeholder={"Your password"}
            inputValue={confirmPassword}
            setInputValue={setConfirmPassword}
            required={true}
            errorMsg={error.confirmPassword}
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
  );
};

export default LoginPage;
