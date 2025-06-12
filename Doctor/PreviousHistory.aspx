<%@ Page Title="" Language="C#" MasterPageFile="~/Doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="PreviousHistory.aspx.cs" Inherits="DBProject.Doctor.PreviousHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Previous History</title>
    <style>
        .history-container {
            max-width: 900px;
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

        @media (max-width: 768px) {
            .history-container {
                padding: 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Cp1" runat="server">

    <div class="history-container">
        <h1 class="history-title">History of Treated Patients</h1>

        <asp:Label ID="PHistory" runat="server" Font-Size="Medium" ForeColor="#2c3e50" />

        <div class="grid-wrapper">
            <asp:GridView ID="PHistoryGrid" runat="server" CssClass="GridView-d" 
                CellPadding="4" ForeColor="Black" GridLines="Vertical"
                EnableViewState="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px">

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

                <Columns>
                    <asp:TemplateField HeaderText="No." ItemStyle-Width="50">
                        <ItemTemplate>
                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                        </ItemTemplate>
                        <ItemStyle Width="50px" />
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>
        </div>
    </div>

</asp:Content>
