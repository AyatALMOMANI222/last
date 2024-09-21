import React, { Fragment } from "react";
import { slide as Menu } from "react-burger-menu";
import "./style.scss";

const MySideDrawer = ({ isOpen, setIsOpen, children }) => {
  const handleStateChange = (state) => {
    setIsOpen(state.isOpen);
  };

  return (
    <Fragment>
      {isOpen && (
        <Menu right isOpen={isOpen} onStateChange={handleStateChange}>
          {children}
        </Menu>
      )}
    </Fragment>
  );
};

export default MySideDrawer;
