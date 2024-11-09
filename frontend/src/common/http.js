import axios from 'axios';
const BaseUrl = process.env.REACT_APP_BASE_URL;;

// Create a new instance of axios with a custom config
const axiosInstance = axios.create({
  baseURL: 'http://127.0.0.1:8000/api',
  timeout: 10000, // Timeout after 10 seconds
  headers: {
    'Content-Type': 'application/json',
    // Add any other headers you want to include by default
  },
});

// Request interceptor for setting up base URL for every request
axiosInstance.interceptors.request.use(
  (config) => {
    // Modify config as needed, such as adding headers or authentication tokens
    return config;
  },
  (error) => {
    // Handle request error
    return Promise.reject(error);
  }
);

// Response interceptor for handling global responses
axiosInstance.interceptors.response.use(
  (response) => {
    // Handle successful responses globally
    return response;
  },
  (error) => {
    // Handle error responses globally
    return Promise.reject(error);
  }
);

export default axiosInstance;
