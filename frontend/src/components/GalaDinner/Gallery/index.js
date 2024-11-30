import React, { useState, useEffect } from "react";
import axios from "axios";
import "./style.scss"; // Import the CSS file
import { backendUrlImages } from "../../../constant/config";

const ImageGallery = () => {
  const [images, setImages] = useState([]); // Initialize state as an empty array
  const [currentPage, setCurrentPage] = useState(1); // Track the current page
  const [totalPages, setTotalPages] = useState(1); // Track total number of pages
  const [loading, setLoading] = useState(false); // Track loading state

  // Function to fetch images based on the current page
  const fetchImages = async (page = 1) => {
    setLoading(true);
    try {
      const response = await axios.get(`http://127.0.0.1:8000/api/get/image?page=${page}`);
      setImages(response.data.data.data); // Assuming response contains data.data.data
      setTotalPages(response.data.data.last_page); // Set total pages from response
      setCurrentPage(page);
    } catch (error) {
      console.error("Error fetching images:", error);
    } finally {
      setLoading(false);
    }
  };

  // Fetch images when the component mounts or when the page changes
  useEffect(() => {
    fetchImages(currentPage);
  }, [currentPage]);

  return (
    <div className="image-gallery-container2">
      <div className="image-gallery">
        {loading ? (
          <p>Loading...</p>
        ) : (
          images?.map((image, index) => (
            <div key={index} className="image-item">
              <img
                src={`${backendUrlImages}/${image.image}`} // Assuming the image URL is stored in "image"
                alt={image.alt_text || "Image"} // Default alt text
                className="gallery-image" // Add a CSS class for the image
              />
              <div className="image-title">{image.conference_title}</div> {/* Display the conference title */}
            </div>
          ))
        )}
      </div>

      {/* Pagination Controls */}
      <div className="pagination-controls">
        <button
          onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
          disabled={currentPage === 1}
        >
          Previous
        </button>
        <span>Page {currentPage} of {totalPages}</span>
        <button
          onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
          disabled={currentPage === totalPages}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default ImageGallery;
