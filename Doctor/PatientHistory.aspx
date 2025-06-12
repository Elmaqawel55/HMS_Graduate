<%@ Page Title="" Language="C#" MasterPageFile="~/Doctor/doctormaster.Master" AutoEventWireup="true" CodeBehind="PatientHistory.aspx.cs" Inherits="doctor.patienthistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Patient History</title>
    <style>
        .history-container {
            max-width: 1000px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .history-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 40px;
        }

        .grid-wrapper {
            overflow-x: auto;
        }

        .GridView-d {
            width: 100%;
            border-collapse: collapse;
        }

        .GridView-d th,
        .GridView-d td {
            padding: 10px;
            text-align: left;
        }
    </style>
    <link rel="stylesheet" href="/assets/css/grid-view.css"/>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Cp1" runat="server">

    <div class="history-container">
        <h1 class="history-title">Today's Appointments</h1>

        <div class="grid-wrapper">
            <asp:GridView ID="patientsgrid" runat="server" CssClass="GridView-d"
                EnableViewState="False"
                AutoGenerateSelectButton="True"
                OnRowCommand="patientsgrid_RowCommand"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
                CellPadding="4" ForeColor="Black" GridLines="Vertical">
                
                <AlternatingRowStyle BackColor="White" />
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />

            </asp:GridView>
        </div>
    </div>

</asp:Content>
