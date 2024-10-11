import axios from "axios";

const httpService = async ({
  method = "GET", // Default method is GET
  url, // API endpoint
  headers = {}, // Custom headers
  data = {}, // Data for POST/PUT requests
  params = {}, // Query parameters for GET requests
  onSuccess, // Success callback
  onError, // Error callback
}) => {
  try {
    const showLoaderEvent = new CustomEvent("showLoader");
    window.dispatchEvent(showLoaderEvent);

    const response = await axios({
      method,
      url,
      headers,
      data,
      params,
    });

    if (onSuccess) {
      onSuccess(response.data);
    }

    return response.data;
  } catch (error) {
    if (onError) {
      onError(error.message);
    }

    throw error;
  } finally {
    const hideLoaderEvent = new CustomEvent("hideLoader");
    window.dispatchEvent(hideLoaderEvent);
  }
};

export default httpService;
