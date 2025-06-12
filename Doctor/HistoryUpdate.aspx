<%@ Page Title="" Language="C#" MasterPageFile="~/Doctor/doctormaster.Master" AutoEventWireup="true" CodeBehind="HistoryUpdate.aspx.cs" Inherits="doctor.Historyupdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Update History</title>
    <style>
        .form-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 40px;
            background-color: #f8f9fa;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', sans-serif;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        h4 {
            color: #34495e;
            margin-top: 20px;
            font-weight: 600;
        }

        input[type="text"], textarea, .form-container asp\:TextBox {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            margin-top: 5px;
        }

        .button-group {
            margin-top: 30px;
            text-align: center;
        }

        .button-group asp\:Button {
            background-color: #4A90E2;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 6px;
            margin: 0 10px;
            cursor: pointer;
            font-weight: bold;
            font-size: 15px;
        }

        .button-group asp\:Button:hover {
            background-color: #357ABD;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Cp1" runat="server">
    <div class="form-container">
        <h1>Update History</h1>

        <h4>Disease:</h4>
        <asp:TextBox ID="Disease" runat="server"></asp:TextBox>

        <h4>Progress:</h4>
        <asp:TextBox ID="progress" runat="server"></asp:TextBox>

        <h4>Prescription:</h4>
        <asp:TextBox ID="Prescription" runat="server"></asp:TextBox>

        <div class="button-group">
            <asp:Button ID="submit" runat="server" Text="Accept & Save" OnClick="saveindatabase" />
            <asp:Button ID="Bill" runat="server" Text="Generate Bill" OnClick="generate_bill" />
        </div>
    </div>
</asp:Content>
