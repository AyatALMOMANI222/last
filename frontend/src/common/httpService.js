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
      onSuccess(response.data);
    }
    if (withToast) {
      toast.success(response?.data?.message);
    }
    return response.data;
  } catch (error) {
    if (onError) {
      onError(error.message);
    }
    if (withToast) {
      toast.error(error?.data?.message);
    }
    throw error;
  } finally {
    if (showLoader) {
      window.dispatchEvent(new CustomEvent("hideLoader"));
    }
  }
};

export default httpService;
