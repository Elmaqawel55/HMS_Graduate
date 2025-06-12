<%@ Page Title="" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="PatientFeedback.aspx.cs" Inherits="DBProject.PatientFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Feedback</title>
    <style>
        .page-container {
            max-width: 800px;
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

        .label-section {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            display: block;
        }

        .feedback-controls {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 30px;
        }

        .feedback-controls select,
        .feedback-controls button {
            margin-top: 10px;
            padding: 10px 20px;
            font-weight: bold;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .feedback-controls button {
            background-color: #2c3e50;
            color: white;
            cursor: pointer;
        }

        .feedback-controls button:hover {
            background-color: #1a242f;
        }

        .feedback-result {
            margin-top: 30px;
            font-weight: bold;
            color: #2c3e50;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-container">
        <div class="title">Feedback</div>

        <asp:Label ID="Feedback" runat="server" CssClass="label-section"></asp:Label>
        <asp:Label ID="FDoctor" runat="server" CssClass="label-section"></asp:Label>
        <asp:Label ID="FTimings" runat="server" CssClass="label-section"></asp:Label>

        <asp:Label ID="Message" runat="server" CssClass="label-section" Visible="false">
            Dear Patient, How was your treatment experience with our specialized Doctor on a rating of 1 - 5:
        </asp:Label>

        <div class="feedback-controls">
            <asp:DropDownList ID="List" runat="server" Visible="false">
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="button1" runat="server" Visible="false" OnClick="giveFeedback" Text="Give Feedback" />
        </div>

        <asp:Label ID="F" runat="server" CssClass="feedback-result"></asp:Label>
    </div>
</asp:Content>
