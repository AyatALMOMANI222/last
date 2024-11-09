import React from "react";
import Dialog from "../../CoreComponent/Dialog";
import doneIcon from "../../icons/doneIcon.svg";
import SVG from "react-inlinesvg";

import "./style.scss";

const DialogMessage = ({ isDialogOpen, setIsDialogOpen, message, onOk, onClose }) => {
  const handleOk = () => {
    if (onOk) onOk();  
    setIsDialogOpen(false);  
  };

  const handleClose = () => {
    if (onClose) onClose();  
    setIsDialogOpen(false);  
  };

  return (
    <div className="dialog-message-container">
      <Dialog
        viewHeader={true}
        header=""
        open={isDialogOpen}
        setOpen={setIsDialogOpen}
      >
        <div className="dialog-message">
          <div className="icon-container-section">
            <SVG
              height={100}
              width={100}
              className="checkbox-icon"
              src={doneIcon}
            />
          </div>
          <div className="message-section">
            {message ||
              `Thank you for applying to speak at the conference. We will notify
            you by email once the admin approves your registration`}
          </div>
          <div className="actions-container">
            <button className="close" onClick={handleClose}>
              Close
            </button>
            <button onClick={handleOk}>Ok</button>
          </div>
        </div>
      </Dialog>
    </div>
  );
};

export default DialogMessage;
