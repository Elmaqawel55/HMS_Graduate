<%@ Page Title="" Language="C#" MasterPageFile="~/Doctor/doctormaster.Master" AutoEventWireup="true" CodeBehind="DoctorHome.aspx.cs" Inherits="doctor.doctorhome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Doctor's Home</title>
    <style>
        .doctor-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px 40px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .doctor-container h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 40px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .info-label {
            width: 48%;
            margin-bottom: 10px;
        }

        .info-label h4 {
            margin: 0;
            font-weight: 600;
            color: #34495e;
        }

        .info-label label {
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
            display: block;
            margin-top: 6px;
        }

        @media (max-width: 768px) {
            .info-label {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Cp1" runat="server">

    <div class="doctor-container">
        <h1>Your Profile</h1>

        <div class="info-row">
            <div class="info-label">
                <h4>Name:</h4>
                <asp:Label ID="Label1" runat="server" />
            </div>
            <div class="info-label">
                <h4>Phone:</h4>
                <asp:Label ID="Label2" runat="server" />
            </div>
        </div>

        <div class="info-row">
            <div class="info-label">
                <h4>Address:</h4>
                <asp:Label ID="Label3" runat="server" />
            </div>
            <div class="info-label">
                <h4>Birth Date:</h4>
                <asp:Label ID="Label4" runat="server" />
            </div>
        </div>

        <div class="info-row">
            <div class="info-label">
                <h4>Gender:</h4>
                <asp:Label ID="Label5" runat="server" />
            </div>
            <div class="info-label">
                <h4>Department No:</h4>
                <asp:Label ID="Label6" runat="server" />
            </div>
        </div>

        <div class="info-row">
            <div class="info-label">
                <h4>Charges Per Visit:</h4>
                <asp:Label ID="Label7" runat="server" />
            </div>
            <div class="info-label">
                <h4>Monthly Salary:</h4>
                <asp:Label ID="Label8" runat="server" />
            </div>
        </div>

        <div class="info-row">
            <div class="info-label">
                <h4>Repute Index:</h4>
                <asp:Label ID="Label9" runat="server" />
            </div>
            <div class="info-label">
                <h4>Patients Treated:</h4>
                <asp:Label ID="Label10" runat="server" />
            </div>
        </div>

        <div class="info-row">
            <div class="info-label">
                <h4>Qualification:</h4>
                <asp:Label ID="Label11" runat="server" />
            </div>
            <div class="info-label">
                <h4>Specialization:</h4>
                <asp:Label ID="Label12" runat="server" />
            </div>
        </div>

        <div class="info-row">
            <div class="info-label">
                <h4>Work Experience:</h4>
                <asp:Label ID="Label13" runat="server" />
            </div>
            <div class="info-label">
                <h4>Status:</h4>
                <asp:Label ID="Label14" runat="server" />
            </div>
        </div>

    </div>

</asp:Content>
