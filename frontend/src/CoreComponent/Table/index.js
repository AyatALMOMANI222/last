import React from "react";
import "./style.scss";

const Table = ({
  headers = [
    { key: "name", label: "Name" },
    { key: "age", label: "Age" },
    { key: "email", label: "Email" },
  ],
  data = [
    { name: "John Doe", age: 30, email: "john@example.com" },
    { name: "Jane Smith", age: 25, email: "jane@example.com" },
    { name: "Tom Johnson", age: 35, email: "tom@example.com" },
    { name: "Alice Williams", age: 28, email: "alice@example.com" },
    { name: "Bob Brown", age: 32, email: "bob@example.com" },
  ],
}) => {
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
