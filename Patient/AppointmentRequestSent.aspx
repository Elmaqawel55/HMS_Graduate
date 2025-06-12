<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="AppointmentRequestSent.aspx.cs" Inherits="DBProject.AppointmentNotificationSent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Send Appointment Request</title>
    <style>
        .request-container {
            max-width: 700px;
            margin: 80px auto;
            padding: 40px;
            background-color: #f0f4f8;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', sans-serif;
            text-align: center;
        }

        .request-container h3 {
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .request-container asp\:Button {
            background-color: #4A90E2;
            color: white;
            padding: 10px 25px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .request-container asp\:Button:hover {
            background-color: #357ABD;
        }

        .request-container asp\:Label {
            display: block;
            margin-top: 30px;
            color: #333;
            font-weight: 500;
            font-size: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="request-container">
        <h3><strong>Click the button below to send an appointment request to the Doctor</strong></h3>

        <asp:Button runat="server" OnClick="sendARequest" Text="Send Request" Font-Bold="true" />

        <asp:Label ID="Message" runat="server"></asp:Label>
    </div>
</asp:Content>
