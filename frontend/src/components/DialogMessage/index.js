import React, { useState } from "react";
import Dialog from "../../CoreComponent/Dialog";
import doneIcon from "../../icons/doneIcon.svg";
import SVG from "react-inlinesvg";

import "./style.scss";
const DialogMessage = ({isDialogOpen, setIsDialogOpen}) => {

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
            Thank you for applying to speak at the conference. We will notify
            you by email once the admin approves your registration
          </div>
          <div className="actions-container">
            <button className="close">Close</button>
            <button>Ok</button>
          </div>
        </div>
      </Dialog>
    </div>
  );
};

export default DialogMessage;
