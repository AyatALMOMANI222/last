import React, { Fragment, useEffect, useRef, useState } from "react";
import SVG from "react-inlinesvg";
import { modules } from "../../constant/modules";
import {
  arrowBottom,
  arrowUp,
  logo,
  settings,
  notification,
} from "../../icons";
import "./style.scss";

const SideDrawer = ({ isExpand, setIsExpand }) => {
  const [selectedItem, setSelectedItem] = useState(null);
  const sideDrawerRef = useRef(null);

  const handleItemClick = (item) => {
    if (item?.children) {
      setSelectedItem(item === selectedItem ? null : item);
    } else {
    }
  };

  const handleOutsideClick = (event) => {
    if (
      sideDrawerRef.current &&
      !sideDrawerRef.current.contains(event.target)
    ) {
      setSelectedItem(null);
    }
  };

  useEffect(() => {
    document.addEventListener("mousedown", handleOutsideClick);
    return () => {
      document.removeEventListener("mousedown", handleOutsideClick);
    };
  }, []);

  return (
    <Fragment>
      <div className={`side-drawer-container  ${isExpand ? "expanded" : ""}`}>
        <div className="logo-container">
          <SVG
            height={37}
            width={37}
            src={logo}
            onClick={() => setIsExpand(!isExpand)}
          ></SVG>
          {!isExpand && <span className="title">PRODUCTS</span>}
        </div>
        <div className="module-children-container" ref={sideDrawerRef}>
          {modules.map((module, index) => {
            return (
              <div key={index}>
                <div className={`module-title`}>
                  <span className={`${isExpand ? "colapps" : ""}`}>
                    {!isExpand && module?.title}
                  </span>
                </div>

                {module?.sections?.map((parentItem, index) => {
                  let isOpen = selectedItem === parentItem;
                  return (
                    <div
                      className={`parent-item-container
                      ${isOpen ? "open" : ""}
                      ${isExpand ? "colapps" : ""}
                      `}
                      key={index}
                    >
                      <div
                        className={`module-container`}
                        onClick={() => handleItemClick(parentItem)}
                      >
                        <div className="module">
                          <SVG src={parentItem.icon}></SVG>
                          {!isExpand && <span>{parentItem.name}</span>}
                        </div>
                        {parentItem?.children && !isExpand && (
                          <SVG src={isOpen ? arrowBottom : arrowUp}></SVG>
                        )}
                      </div>
                      {isOpen && (
                        <div
                          className={`children-container ${
                            isExpand ? "colapps" : ""
                          }`}
                        >
                          {parentItem?.children?.map(
                            (childItem, childIndex) => (
                              <div
                                className={`child ${isExpand ? "colapps" : ""}`}
                                key={childIndex}
                                onClick={() => {
                                  if (childItem?.onclick) {
                                    childItem?.onclick();
                                  }
                                }}
                              >
                                {childItem.name}
                              </div>
                            )
                          )}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            );
          })}
        </div>

        <div className="lower-part-container">
          <div className="section">
            <SVG src={notification}></SVG>
            {!isExpand && <span>Notification</span>}
          </div>
          <div className="section">
            <SVG src={settings}></SVG>
            {!isExpand && <span>Settings</span>}
          </div>
        </div>
      </div>
    </Fragment>
  );
};

export default SideDrawer;
