import React from "react";
import "./style.scss";

const Table = ({ headers = [], data = [] }) => {
  return (
    <div className="table-container">
      <table className="table">
        <thead>
          <tr>
            {headers?.map((header) => (
              <th key={header.key}>{header.label}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {data?.map((row, index) => (
            <tr key={index}>
              {headers.map((header) => (
                <td key={header?.key}>{row[header?.key]}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Table;
