<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="PatientHome.aspx.cs" Inherits="DBProject.PatientHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Patient's Home</title>
    <style>
        .home-container {
            background-image: url('/assets/img/backgrounds/PatientHome.jpg');
            background-size: cover;
            background-position: center;
            padding: 60px 0;
            min-height: 100vh;
        }

        .info-card {
            background-color: rgba(255, 255, 255, 0.95);
            max-width: 700px;
            margin: 0 auto;
            padding: 40px 60px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            font-family: 'Segoe UI', sans-serif;
        }

        .info-card h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .info-field {
            margin-bottom: 20px;
        }

        .info-field h4 {
            margin: 0;
            font-weight: bold;
            color: #34495e;
        }

        .info-field label {
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
            display: inline-block;
            margin-top: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="home-container">
        <div class="info-card">
            <h1>Your Information</h1>

            <div class="info-field">
                <h4>Name:</h4>
                <asp:Label ID="PName" runat="server" />
            </div>

            <div class="info-field">
                <h4>Phone:</h4>
                <asp:Label ID="PPhone" runat="server" />
            </div>

            <div class="info-field">
                <h4>Birth Date:</h4>
                <asp:Label ID="PBirthDate" runat="server" />
            </div>

            <div class="info-field">
                <h4>Age:</h4>
                <asp:Label ID="PatientAge" runat="server" />
            </div>

            <div class="info-field">
                <h4>Gender:</h4>
                <asp:Label ID="PGender" runat="server" />
            </div>

            <div class="info-field">
                <h4>Address:</h4>
                <asp:Label ID="PAddress" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
