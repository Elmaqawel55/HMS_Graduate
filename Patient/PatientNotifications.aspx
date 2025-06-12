<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="PatientNotifications.aspx.cs" Inherits="DBProject.PatientNotifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Notifications</title>
    <style>
        .notification-container {
            max-width: 700px;
            margin: 50px auto;
            background-color: #fdfdfd;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .notification-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .notification-label {
            font-weight: bold;
            font-size: 16px;
            color: #333;
            display: block;
            margin-bottom: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="notification-container">
        <h1 class="notification-title">Notifications</h1>

        <asp:Label ID="Notify" runat="server" CssClass="notification-label"></asp:Label>
        <asp:Label ID="NDoctor" runat="server" CssClass="notification-label"></asp:Label>
        <asp:Label ID="NTimings" runat="server" CssClass="notification-label"></asp:Label>
    </div>

</asp:Content>
