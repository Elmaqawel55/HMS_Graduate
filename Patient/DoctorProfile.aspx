<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="DoctorProfile.aspx.cs" Inherits="DBProject.DoctorProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Doctor's Profile</title>
    <style>
        .page-container {
            max-width: 900px;
            margin: 60px auto;
            padding: 40px;
            background-color: #f9f9f9;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            font-family: 'Segoe UI', sans-serif;
        }

        .title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 40px;
        }

        .profile-label {
            font-weight: bold;
            font-size: 16px;
            margin-top: 20px;
            color: #34495e;
        }

        .profile-value {
            font-size: 16px;
            color: #2c3e50;
            margin-bottom: 10px;
            display: block;
        }

        .btn-appointment {
            margin-top: 30px;
            background-color: #3498db;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-appointment:hover {
            background-color: #2980b9;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-container">
        <div class="title">Doctor's Profile</div>

        <div>
            <label class="profile-label">Name:</label>
            <asp:Label ID="DName" runat="server" CssClass="profile-value" />

            <label class="profile-label">Phone:</label>
            <asp:Label ID="DPhone" runat="server" CssClass="profile-value" />

            <label class="profile-label">Qualification:</label>
            <asp:Label ID="DQualification" runat="server" CssClass="profile-value" />

            <label class="profile-label">Specialization:</label>
            <asp:Label ID="DSpecialization" runat="server" CssClass="profile-value" />

            <label class="profile-label">Work Experience:</label>
            <asp:Label ID="DWork" runat="server" CssClass="profile-value" />

            <label class="profile-label">Age:</label>
            <asp:Label ID="DAge" runat="server" CssClass="profile-value" />

            <label class="profile-label">Gender:</label>
            <asp:Label ID="DGender" runat="server" CssClass="profile-value" />

            <label class="profile-label">Department:</label>
            <asp:Label ID="DDept" runat="server" CssClass="profile-value" />

            <label class="profile-label">Charges Per Appointment:</label>
            <asp:Label ID="DCharges" runat="server" CssClass="profile-value" />

            <label class="profile-label">Repute Index:</label>
            <asp:Label ID="DRI" runat="server" CssClass="profile-value" />

            <label class="profile-label">Number of Patients Treated:</label>
            <asp:Label ID="DPT" runat="server" CssClass="profile-value" />

            <asp:Button ID="AppointmentB" runat="server" Text="Take Appointment" OnClick="RedirectToAppointmentTaker" CssClass="btn-appointment" />
        </div>
    </div>
</asp:Content>
