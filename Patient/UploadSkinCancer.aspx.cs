using System;
using System.IO;

namespace DBProject
{
    public partial class UploadSkinCancer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ResultLabel.Text = "";
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                try
                {
                    string filename = Path.GetFileName(FileUpload1.FileName);
                    string folderPath = Server.MapPath("~/UploadedImages/SkinCancer/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string fullPath = Path.Combine(folderPath, filename);
                    FileUpload1.SaveAs(fullPath);

                    ResultLabel.ForeColor = System.Drawing.Color.Green;
                    ResultLabel.Text = "File uploaded successfully! File saved as: " + filename;
                }
                catch (Exception ex)
                {
                    ResultLabel.ForeColor = System.Drawing.Color.Red;
                    ResultLabel.Text = "Error uploading file: " + ex.Message;
                }
            }
            else
            {
                ResultLabel.ForeColor = System.Drawing.Color.Red;
                ResultLabel.Text = "Please select a file to upload.";
            }
        }
    }
}
