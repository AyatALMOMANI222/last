import React, { useState, useEffect, useCallback, Fragment } from "react";
import Table from "../../../CoreComponent/Table";
import httpService from "../../../common/httpService";
import Select from "../../../CoreComponent/Select";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import Pagination from "../../../CoreComponent/Pagination";
import DialogMessage from "../../DialogMessage";
import { toast } from "react-toastify";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import SimpleLabelValue from "../../SimpleLabelValue";
import { backendUrlImages } from "../../../constant/config";
import ImageUpload from "../../../CoreComponent/ImageUpload";

const PendingUsersTable = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const navigate = useNavigate();
  const [pendingUsers, setPendingUsers] = useState([]);
  const [status, setStatus] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [sponsorData, setSponsorData] = useState({});
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [selectedUser, setSelectedUser] = useState(null);

  const statusOptions = [
    { value: "pending", label: "Pending" },
    { value: "approved", label: "Approved" },
    { value: "rejected", label: "Rejected" },
    { value: "all", label: "All" },
  ];

  const getAuthToken = () => localStorage.getItem("token");

  const fetchPendingUsers = useCallback(async () => {
    const url = `${BaseUrl}/users?status=${
      status?.value || "all"
    }&page=${currentPage}`;

    try {
      const response = await httpService({
        method: "GET",
        url,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
      });

      const usersWithActions = response?.data?.map((user) => {
        return {
          ...user,
          name: user?.name || user?.company_name,
          actions: (
            <div className="actions-buttons-list">
              <button
                className="view-btn"
                onClick={() => {
                  setSelectedUser(user);
                  setIsDrawerOpen(true);
                }}
              >
                View
              </button>
              <button
                className={`view-btn ${
                  user?.status !== "pending" && "disabled-btn"
                } `}
                onClick={() => {
                  if (user?.registration_type === "speaker") {
                    navigate(
                      `/edit/speaker/data/${user.conferences?.[0]?.id}/${user.id}`
                    );
                  } else if (user?.registration_type === "attendance") {
                    navigate(
                      `/edit/attendance/data/${user.conference_id}/${user.id}`
                    );
                  } else if (user?.registration_type === "sponsor") {
                    const sponsor = {
                      user_id: user?.id,
                      conference_id: user?.conference_id,
                      company_name: user?.company_name,
                      contact_person: user?.contact_person,
                      company_address: user?.company_address,
                      registration_type: user?.registration_type,
                    };
                    setSponsorData(sponsor);
                    setIsDialogOpen(true);
                  } else if (user?.registration_type === "group_registration") {
                    navigate(`/group/update/admin/${user.id}`);
                  } else if (!user?.registration_type) {
                    navigate(`/adminForm/${user.id}`);
                  }
                }}
                disabled={user?.status !== "pending"}
              >
                Submit
              </button>
            </div>
          ),
        };
      });

      setPendingUsers(usersWithActions);
      setTotalPages(response.pagination?.total_pages);
      setCurrentPage(response.pagination?.current_page);
    } catch (err) {
      toast.error("Failed to fetch users.");
    }
  }, [status, currentPage, navigate]);

  useEffect(() => {
    fetchPendingUsers();
  }, [fetchPendingUsers]);

  const headers = [
    { key: "name", label: "Name" },
    { key: "email", label: "Email" },
    { key: "phone_number", label: "Phone Number" },
    { key: "whatsapp_number", label: "WhatsApp Number" },
    { key: "specialization", label: "Specialization" },
    { key: "country_of_residence", label: "Country of Residence" },
    { key: "registration_type", label: "Registration Type" },
    { key: "status", label: "Status" },
    { key: "actions", label: "Actions" },
  ];

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const approveSponsor = async () => {
    try {
      await httpService({
        method: "POST",
        url: `${BaseUrl}/approve/sponsor`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        data: sponsorData,
        withToast: true,
      });
    } catch (error) {
      toast.error("Something went wrong, please try again.");
    }
  };

  return (
    <div className="pending-users-container">
      <h2>All Users</h2>
      <DialogMessage
        isDialogOpen={isDialogOpen}
        setIsDialogOpen={setIsDialogOpen}
        message="Are you sure you want to approve this user?"
        onOk={approveSponsor}
        onClose={() => setIsDialogOpen(false)}
      />
      <Select
        options={statusOptions}
        value={status}
        setValue={setStatus}
        label="Visa Status"
      />
      <Table headers={headers} data={pendingUsers} />
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />
      <MySideDrawer isOpen={isDrawerOpen} setIsOpen={setIsDrawerOpen}>
        <CustomFormWrapper
          title="User Details"
          handleSubmit={() => setIsDrawerOpen(false)}
          setOpenForm={setIsDrawerOpen}
          noActions={true}
        >
          {selectedUser && (
            <div className="users-details">
              <SimpleLabelValue label="Name" value={selectedUser.name || "-"} />
              <SimpleLabelValue
                label="Email"
                value={selectedUser.email || "-"}
              />
              <SimpleLabelValue
                label="Phone Number"
                value={selectedUser.phone_number || "-"}
              />
              <SimpleLabelValue
                label="WhatsApp Number"
                value={selectedUser.whatsapp_number || "-"}
              />
              <SimpleLabelValue
                label="Nationality"
                value={selectedUser.nationality || "-"}
              />
              <SimpleLabelValue
                label="Country of Residence"
                value={selectedUser.country_of_residence || "-"}
              />
              <SimpleLabelValue
                label="Status"
                value={selectedUser.status || "-"}
              />
              <SimpleLabelValue
                label="Registration Type"
                value={selectedUser.registration_type || "-"}
              />
              <SimpleLabelValue
                label="Biography"
                value={selectedUser.biography || "-"}
              />
              <SimpleLabelValue
                label="Company Name"
                value={selectedUser.company_name || "-"}
              />
              <SimpleLabelValue
                label="Contact Person"
                value={selectedUser.contact_person || "-"}
              />
              <SimpleLabelValue
                label="Company Address"
                value={selectedUser.company_address || "-"}
              />
              <SimpleLabelValue
                label="Conferences"
                value={
                  selectedUser.conferences?.length
                    ? selectedUser.conferences
                        .map(
                          (conference) =>
                            `${conference.title} (Location: ${conference.location}, Status: ${conference.status})`
                        )
                        .join(", ")
                    : "-"
                }
              />
              {selectedUser.papers?.length
                ? selectedUser.papers.map((paper, index) => (
                    <Fragment key={index}>
                      <SimpleLabelValue
                        label="Paper Title"
                        value={paper.title}
                      />
                      <SimpleLabelValue
                        label="Abstract"
                        value={
                          <img
                            src={`${backendUrlImages}${paper.file_path}`}
                            className="conference-thumbnail"
                          />
                          // <ImageUpload
                          //   required
                          //   label="Abstract"
                          //   allowedExtensions={["txt", "pdf", "doc", "docx"]}
                          //   // inputValue={formFiles.abstract}
                          //   existingFile={paper.abstract}
                          //   // setInputValue={handleFileChange("abstract")}
                          //   className="image-upload"
                          //   placeholder="Abstract"
                          // />
                        }
                      />
                      <SimpleLabelValue
                        label="Paper Status"
                        value={paper.status}
                      />
                    </Fragment>
                  ))
                : "-"}
            </div>
          )}
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default PendingUsersTable;
