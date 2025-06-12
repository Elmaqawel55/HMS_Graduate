<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="DBProject.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-title {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
            background-color: #4A90E2;
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
            font-size: 32px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .section {
            margin: 40px auto;
            max-width: 900px;
            padding: 30px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .section h3, .section h2 {
            color: #333;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 600;
        }

        .section h4 {
            margin-top: 20px;
            font-size: 18px;
            color: #444;
        }

        .label-text {
            display: inline-block;
            margin-top: 5px;
            font-size: 16px;
            font-weight: bold;
            color: #2d2d2d;
        }

        .gridview {
            margin-top: 30px;
            width: 100%;
        }

        .gridview-header {
            background-color: #4A90E2 !important;
            color: white !important;
            font-weight: bold;
        }

        .gridview-row {
            background-color: #f0f8ff;
        }

        .gridview-alt {
            background-color: #e6f2ff;
        }

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">

        <h1 class="page-title">Clinic Statistics</h1>

        <div class="section">
            <h4><strong>Total Number of Registered Doctors:</strong></h4>
            <asp:Label ID="TotalPatients" runat="server" CssClass="label-text"></asp:Label>

            <h4><strong>Total Registered Patients:</strong></h4>
            <asp:Label ID="Total_Doctors" runat="server" CssClass="label-text"></asp:Label>

            <h4><strong>Total Income:</strong></h4>
            <asp:Label ID="TotalIncome" runat="server" CssClass="label-text"></asp:Label>

            <h3>Current Appointments</h3>

            <asp:GridView ID="Appointment_view" runat="server" CssClass="gridview" AutoGenerateColumns="true"
                CellPadding="6" GridLines="Horizontal" BorderStyle="Solid" BorderWidth="1px"
                HeaderStyle-CssClass="gridview-header"
                RowStyle-CssClass="gridview-row"
                AlternatingRowStyle-CssClass="gridview-alt">
            </asp:GridView>
        </div>

        <div class="section">
            <h2>Department Information</h2>

            <asp:GridView ID="department_View" runat="server" CssClass="gridview" AutoGenerateColumns="true"
                CellPadding="6" GridLines="Horizontal" BorderStyle="Solid" BorderWidth="1px"
                HeaderStyle-CssClass="gridview-header"
                RowStyle-CssClass="gridview-row"
                AlternatingRowStyle-CssClass="gridview-alt">
            </asp:GridView>
        </div>

    </form>
</asp:Content>
