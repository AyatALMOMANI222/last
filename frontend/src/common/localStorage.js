export const saveToLocalStorage = (key, value) => {
    try {
      const serializedValue = JSON.stringify(value);
      localStorage.setItem(key, serializedValue);
    } catch (error) {
      console.error("Error saving to localStorage", error);
    }
  };
  
  export const getFromLocalStorage = (key) => {
    try {
      const serializedValue = localStorage.getItem(key);
      return serializedValue ? JSON.parse(serializedValue) : null;
    } catch (error) {
      console.error("Error retrieving from localStorage", error);
      return null;
    }
  };
  export const removeFromLocalStorage = (key) => {
    try {
      localStorage.removeItem(key);
    } catch (error) {
      console.error("Error removing from localStorage", error);
    }
  };

  export const removeFromLocalStorageStartWith = (prefix) => {
    try {
      // Iterate through all keys in localStorage
      Object.keys(localStorage).forEach((key) => {
        // Check if the key starts with the specified prefix
        if (key.startsWith(prefix)) {
          // Remove the item from localStorage
          localStorage.removeItem(key);
        }
      });
    } catch (error) {
      console.error("Error removing from localStorage", error);
    }
  };
  