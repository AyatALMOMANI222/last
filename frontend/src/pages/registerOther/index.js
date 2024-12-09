import React, { useState } from "react";
import { toast } from "react-toastify";
import axios from "axios";
import "./style.scss";
import Input from "../../CoreComponent/Input";
import { useNavigate } from "react-router-dom";

const RegisterOther = () => {
  const navigate = useNavigate();
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState({
    name: "",
    email: "",
    password: "",
  });

  const handleSubmit = async () => {
    const userData = {
      name,
      email,
      password,
    };

    try {
      const response = await axios.post(`${BaseUrl}/store/user`, userData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      toast.success("User created successfully!");
      console.log(response);
      
    } catch (error) {
      if (error.response) {
        toast.error(error.response.data.error);
      } else {
      }
    }
  };

  const handleRegister = (e) => {
    e.preventDefault();
    let errorName = "";
    let errorEmail = "";
    let errorPassword = "";

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // Name validation
    if (!name) {
      errorName = "Please enter your name.";
    }

    // Email validation
    if (!email) {
      errorEmail = "Please enter your email.";
    } else if (!emailRegex.test(email)) {
      errorEmail = "Please enter a valid email.";
    }

    // Password validation
    if (!password) {
      errorPassword = "Please enter your password.";
    }

    setError({
      name: errorName,
      email: errorEmail,
      password: errorPassword,
    });

    if (!errorName && !errorEmail && !errorPassword) {
      setError({
        name: "",
        email: "",
        password: "",
      });
      handleSubmit();
    }
  };

  return (
    <div>
      <div className="register-page-container3">
        <form onSubmit={handleRegister} className="register-form">
          <div className="title">
            <span>Register</span>
            <span
            className="login-span"
              onClick={() => {
                navigate("/login");
              }}
            >
              login
            </span>
          </div>

          <div className="fields-container">
            <Input
              label="Name"
              placeholder="Enter your name"
              inputValue={name}
              setInputValue={setName}
              required={true}
              errorMsg={error.name}
            />
            <Input
              label="Email"
              placeholder="Enter your email"
              inputValue={email}
              setInputValue={setEmail}
              required={true}
              errorMsg={error.email}
            />
            <Input
              label="Password"
              placeholder="Enter your password"
              inputValue={password}
              setInputValue={setPassword}
              type="password"
              required={true}
              errorMsg={error.password}
            />
          </div>

          <div className="register-btn-container">
            <button className="register-btn" type="submit">
              Register
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default RegisterOther;
