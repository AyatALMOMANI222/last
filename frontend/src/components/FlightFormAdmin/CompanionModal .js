import React, { useState, useEffect } from 'react';
import Table from "../../CoreComponent/Table";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import SeatCostForm from './costForm';
import AddTripForm from './tripForm';
import "./CompanionModal.scss";

const CompanionModal = ({ isOpen, setIsOpen, companions, headers }) => {
  const [openTripForm, setOpenTripForm] = useState(false);
  const [openPriceForm, setOpenPriceForm] = useState(false);
  const [selectedItem, setSelectedItem] = useState(null); // null بدلاً من كائن فارغ

  // تعديل البيانات لإضافة عمود للأزرار
  const modifiedCompanions = companions.map(item => ({
    ...item,
    actions: (
      <div className="table-actions-container">
        <button className="trip-btn" onClick={() => {
          setSelectedItem(item); // تعيين العنصر أولاً
          setOpenTripForm(true); // ثم فتح النموذج
        }}>Add Trip</button>
        <button className="price-btn" onClick={() => {
          setSelectedItem(item); // تعيين العنصر أولاً
          setOpenPriceForm(true); // ثم فتح النموذج
        }}>Add Price</button>
      </div>
    )
  }));

  // استخدام useEffect للتأكد من أن selectedItem تم تحديثه قبل فتح النموذج
  useEffect(() => {
    if (openTripForm && selectedItem) {
      console.log('Selected Item:', selectedItem);
    }
  }, [openTripForm, selectedItem]);

  return (
    <div className="companion-modal">
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <h2>Companion Flights</h2>
        <Table headers={headers} data={modifiedCompanions} />
      </MySideDrawer>

      {selectedItem && (
        <MySideDrawer isOpen={openTripForm} setIsOpen={setOpenTripForm}>
          <AddTripForm data={selectedItem} setOpen={setOpenTripForm} />
        </MySideDrawer>
      )}

      {selectedItem && (
        <MySideDrawer isOpen={openPriceForm} setIsOpen={setOpenPriceForm}>
          <SeatCostForm data={selectedItem} setOpen={setOpenPriceForm} />
        </MySideDrawer>
      )}
    </div>
  );
};

export default CompanionModal;
