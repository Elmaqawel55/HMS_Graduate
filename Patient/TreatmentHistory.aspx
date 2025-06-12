<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="TreatmentHistory.aspx.cs" Inherits="DBProject.TreatmentHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Treatment History</title>
    <style>
        .page-container {
            max-width: 1200px;
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

        .GridView-d {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .GridView-d th {
            background-color: #34495e;
            color: white;
            padding: 16px;
            text-align: left;
        }

        .GridView-d td {
            padding: 14px;
            background-color: #ffffff;
            border-bottom: 1px solid #ddd;
        }

        .GridView-d tr:nth-child(even) td {
            background-color: #f2f6f9;
        }

        .GridView-d tr:hover td {
            background-color: #e0f7fa;
        }

        .label-section {
            text-align: center;
            font-size: 16px;
            margin-bottom: 30px;
            color: #333;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-container">
        <div class="title">Your Treatment History</div>

        <asp:Label ID="THistory" runat="server" CssClass="label-section"></asp:Label>

        <asp:GridView ID="THistoryGrid" runat="server" CssClass="GridView-d"
            CellPadding="4"
            ForeColor="Black"
            GridLines="None"
            Width="100%"
            EnableViewState="False"
            BackColor="White"
            BorderStyle="None">
            <Columns>
                <asp:TemplateField HeaderText="No." ItemStyle-Width="60">
                    <ItemTemplate>
                        <asp:Label ID="lblRowNumber" runat="server" Text='<%# Container.DataItemIndex + 1 %>' />
                    </ItemTemplate>
                    <ItemStyle Width="60px" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
