export const toggleToDarkMode = () => {
  const customStyles = [
    { name: "--primary-color", value: "#3a6cd1" },
    { name: "--secondary-color", value: "#ebecf2" },
    { name: "--tertiary-color", value: "#6f6f6f" },
    { name: "--background-color", value: "#12131A" },
    { name: "--border-color", value: "#7c7c7c" },
    { name: "--text-color", value: "#d3d3d3" },
    { name: "--hover-color", value: "#f1f2f69f" },
    { name: "--shadow-color", value: "rgba(0, 0, 0, 0.26)" },
    { name: "--scrollbar-track-color", value: "#f1f1f1" },
    { name: "--scrollbar-thumb-color", value: "#888" },
    { name: "--scrollbar-thumb-hover-color", value: "#555555ac" },
    { name: "--main-color", value: "#252833" },
    { name: "--element-color", value: "#fff" },
  ];

  customStyles.forEach(({ name, value }) => {
    document.documentElement.style.setProperty(name, value);
  });
};

export const toggleToLightMode = () => {
  const customStyles = {
    "--primary-color": "#3a6cd1",
    "--secondary-color": "#ebecf2",
    "--tertiary-color": "#9a9eb2",
    "--background-color": "#f8f8fb",
    "--border-color": "#d8dae5",
    "--text-color": "#515360",
    "--hover-color": "#f1f2f69f",
    "--shadow-color": "rgba(0, 0, 0, 0.26)",
    "--scrollbar-track-color": "#f1f1f1",
    "--scrollbar-thumb-color": "#888",
    "--scrollbar-thumb-hover-color": "#555555ac",
    "--main-color": "#f1f2f675",
    "--element-color": "rgb(20, 36, 82)",
  };

  Object.entries(customStyles).forEach(([key, value]) => {
    document.documentElement.style.setProperty(key, value);
  });
};
