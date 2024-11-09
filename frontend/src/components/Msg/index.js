import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './style.scss';

const Messages = () => {
  const [messages, setMessages] = useState([]);
  const [error, setError] = useState(null);
  const token = localStorage.getItem("token"); // استبدلها بالتوكن المناسب
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  useEffect(() => {
    axios
      .get(`${BaseUrl}/messages`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then(response => {
        setMessages(response.data.messages.reverse());
      })
      .catch(error => {
        setError('Failed to fetch messages. Please try again later.');
      });
  }, []);

  return (
    <div className="messages-container">
      <h2>Messages</h2>
      {error && <p className="error-message">{error}</p>}
      {messages.length === 0 ? (
        <p className="no-messages">No messages available.</p>
      ) : (
        <div className="messages-list">
          {messages.map(msg => (
            <div key={msg.id} className="message-card">
              <h3>{msg.subject}</h3>
              <p><strong>Name:</strong> {msg.name}</p>
              <p><strong>Email:</strong> {msg.email}</p>
              <p><strong>Message:</strong> {msg.message}</p>
              <p className="timestamp">Sent at: {new Date(msg.created_at).toLocaleString()}</p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default Messages;
