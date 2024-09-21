import React, { useState } from "react";
import "./style.scss";
const DonutChart = ({
  data = [
    { label: "Fiction", value: 40, color: "#ff6384" },
    { label: "Non-Fiction", value: 30, color: "#36a2eb" },
    { label: "Mystery", value: 20, color: "#ffcd56" },
    { label: "Romance", value: 10, color: "#43e3e3" },
  ],
  size = 270,
}) => {
  const [selectedLabel, setSelectedLabel] = useState("");
  const radius = size / 2;
  const thickness = 40;
  const total = data.reduce((sum, { value }) => sum + value, 0);
  let cumulativePercentage = 0;

  const getCoordinatesForPercent = (percent) => {
    const x = Math.cos(2 * Math.PI * percent) * radius;
    const y = Math.sin(2 * Math.PI * percent) * radius;
    return [x, y];
  };

  return (
    <div className="chart-container">
      <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
        {data.map((slice, index) => {
          const startPercentage = cumulativePercentage;
          cumulativePercentage += slice.value / total;
          const [startX, startY] = getCoordinatesForPercent(startPercentage);
          const [endX, endY] = getCoordinatesForPercent(cumulativePercentage);
          const largeArcFlag = slice.value / total > 0.5 ? 1 : 0;

          return (
            <g key={index}>
              <path
                d={`M ${radius + startX} ${radius + startY}
                    A ${radius} ${radius} 0 ${largeArcFlag} 1 ${
                  radius + endX
                } ${radius + endY}
                    L ${radius} ${radius}`}
                fill={
                  selectedLabel === slice.label || !selectedLabel
                    ? slice.color
                    : "#dfdddd"
                }
                stroke="#fff"
                strokeWidth="2"
              />
            </g>
          );
        })}
        <circle cx={radius} cy={radius} r={radius - thickness} fill="#fff" />


      </svg>
     
      <ul className="chart-labels">
        {data.map((slice, index) => {
          return (
            <li
              key={index}
              className="chart-label"
              onClick={() => setSelectedLabel(slice.label)}
            >
              <span
                className="label-color"
                style={{ backgroundColor: slice.color }}
              ></span>
              {slice.label} ({Math.round((slice.value / total) * 100)}%)
            </li>
          );
        })}
        <li className="chart-label" onClick={() => setSelectedLabel(null)}>
          <span
            className="label-color"
            style={{ backgroundColor: "green" }}
          ></span>
          All 100%
        </li>
      </ul>
    </div>
  );
};

export default DonutChart;
