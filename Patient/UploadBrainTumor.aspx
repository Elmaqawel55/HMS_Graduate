<%@ Page Title="Brain Tumor Upload" Language="C#" MasterPageFile="~/Patient/PatientMaster.Master" AutoEventWireup="true" CodeBehind="UploadBrainTumor.aspx.cs" Inherits="DBProject.UploadBrainTumor" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Upload Brain MRI</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin: 50px auto; width: 50%; padding: 20px; border: 1px solid #ccc; background-color: #f9f9f9; text-align:center;">
        <h2 style="color:#003366; font-weight:bold; margin-bottom: 30px;">Upload Brain MRI Image</h2>
        <hr />
        
        <h4 style="color:#00509E; font-weight:bold; margin-top: 30px; margin-bottom: 15px;">Please select the Brain MRI image file to upload:</h4>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br /><br />
        <asp:Button ID="UploadButton" runat="server" Text="Upload and Predict" OnClick="UploadButton_Click" CssClass="btn btn-primary" />
        <br /><br />
        <asp:Label ID="ResultLabel" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
    </div>
</asp:Content>
