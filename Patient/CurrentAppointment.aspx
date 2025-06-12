<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="CurrentAppointment.aspx.cs" Inherits="DBProject.CurrentAppointment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Current Appointment</title>
    <style>
        .appointment-container {
            max-width: 700px;
            margin: 50px auto;
            background-color: #fefefe;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .appointment-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .appointment-label {
            font-weight: bold;
            font-size: 16px;
            color: #34495e;
            display: block;
            margin-bottom: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="appointment-container">
        <h1 class="appointment-title">Current Appointment</h1>

        <asp:Label ID="Appointment" runat="server" CssClass="appointment-label" />
        <asp:Label ID="ADoctor" runat="server" CssClass="appointment-label" />
        <asp:Label ID="ATimings" runat="server" CssClass="appointment-label" />
    </div>

</asp:Content>
