import axios from "axios";
import { toast } from "react-toastify";
const httpService = async ({
  method = "GET",
  url,
  headers = {},
  data = {},
  params = {},
  onSuccess,
  onError,
  showLoader = false,
  withToast = false,
}) => {
  if (!url) {
    throw new Error("URL is required");
  }

  try {
    if (showLoader) {
      window.dispatchEvent(new CustomEvent("showLoader"));
    }

    const response = await axios({
      method,
      url,
      headers,
      data,
      params,
    });

    if (onSuccess) {
      onSuccess(response?.data);
    }
    if (withToast) {
      if (response?.data?.message) {
        if (toast && toast.props) {
          toast.success(response?.data?.message || "");
        }
      }
    }
    return response.data;
  } catch (error) {
    if (onError) {
      onError(error.message);
    }
    if (withToast && error?.data?.message) {
      if (toast && toast.props) {
        toast.error(error?.data?.message || "");
      }
    }
    throw error;
  } finally {
    if (showLoader) {
      setTimeout(() => {
        window.dispatchEvent(new CustomEvent("hideLoader"));
      }, 300);
    }
  }
};

export default httpService;
