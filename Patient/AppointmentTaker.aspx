<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="AppointmentTaker.aspx.cs" Inherits="DBProject.AppointmentTaker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Appointment Taker</title>
    <style>
        .page-container {
            max-width: 900px;
            margin: 60px auto;
            background-color: #f0f4f8;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', sans-serif;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        .gridview-container {
            overflow-x: auto;
            margin-top: 30px;
        }

        .GridView-d {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            font-size: 15px;
            color: #333;
        }

        .GridView-d th {
            background-color: #4A90E2;
            color: white;
            padding: 10px;
            text-align: center;
        }

        .GridView-d td {
            background-color: #ffffff;
            padding: 10px;
            text-align: center;
        }

        .GridView-d tr:nth-child(even) td {
            background-color: #f2f6fa;
        }

        .GridView-d tr:hover td {
            background-color: #e2eefa;
        }

        .GridView-d .selected {
            background-color: #4CAF50 !important;
            color: white;
        }

        asp\:Label {
            display: block;
            margin-bottom: 20px;
            font-weight: bold;
            color: #34495e;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-container">
        <h1><strong>Free Time Slots</strong></h1>

        <asp:Label ID="PAppointment" runat="server"></asp:Label>

        <div class="gridview-container">
            <asp:GridView ID="PAppointmentGrid" runat="server" CssClass="GridView-d" CellPadding="4" GridLines="Vertical"
                Width="100%" AutoGenerateSelectButton="true" OnRowCommand="PAppointmentGrid_RowCommand" AutoGenerateColumns="true" EnableViewState="False"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px">

                <Columns>
                    <asp:TemplateField HeaderText="No." ItemStyle-Width="50">
                        <ItemTemplate>
                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                        </ItemTemplate>
                        <ItemStyle Width="50px"></ItemStyle>
                    </asp:TemplateField>
                </Columns>

                <AlternatingRowStyle BackColor="White" />
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#4A90E2" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" />
                <SelectedRowStyle BackColor="#4CAF50" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#A7D5F2" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#6B696B" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
