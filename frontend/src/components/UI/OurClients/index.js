import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './style.scss';

const OurClients = () => {
  const [clients, setClients] = useState([]); // حالة لتخزين العملاء
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  useEffect(() => {
    // دالة لجلب العملاء
    const fetchClients = () => {
      axios.get(`${BaseUrl}/clients`)
        .then(response => {
          console.log(response.data);
          setClients(response.data); // تحديث حالة العملاء
        })
        .catch(error => {
          // طباعة الخطأ
          console.error('Error fetching clients:', error.response ? error.response.data : error.message);
        });
    };

    fetchClients(); // استدعاء دالة جلب العملاء
  }, []); // فقط عند تحميل المكون

  return (
    <div className="clients-container">
      <h2 className="clients-title">Our Clients</h2>
      <div className="clients-skew">
        {clients.map((client) => (
          <div className="clients-logo" key={client.id}>
            <img src={`http://127.0.0.1:8000/storage/${client.image}`} alt="Client Logo" className="client-logo" />
            {/* <p>{client.description}</p> */}
          </div>
        ))}
      </div>
    </div>
  );
};

export default OurClients;
