using System;
using System.IO;
using System.Net;
using System.Text;
using System.Drawing;
using Newtonsoft.Json.Linq;

namespace DBProject
{
    public partial class UploadBrainTumor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ResultLabel.Text = "";
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (!FileUpload1.HasFile)
            {
                ResultLabel.ForeColor = Color.Red;
                ResultLabel.Text = "Please select an image file first.";
                return;
            }

            try
            {
                string apiUrl = "http://localhost:5000/predict/brain";
                string boundary = "----Boundary" + DateTime.Now.Ticks.ToString("x");
                byte[] fileData = FileUpload1.FileBytes;
                string fileName = Path.GetFileName(FileUpload1.FileName);
                string contentType = FileUpload1.PostedFile.ContentType;

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(apiUrl);
                request.Method = "POST";
                request.ContentType = "multipart/form-data; boundary=" + boundary;
                request.KeepAlive = true;

                // بناء الجسم body
                using (Stream reqStream = request.GetRequestStream())
                {
                    // header
                    string header =
                        $"--{boundary}\r\n" +
                        $"Content-Disposition: form-data; name=\"image\"; filename=\"{fileName}\"\r\n" +
                        $"Content-Type: {contentType}\r\n\r\n";
                    byte[] headerBytes = Encoding.UTF8.GetBytes(header);
                    reqStream.Write(headerBytes, 0, headerBytes.Length);

                    // ملف الصورة
                    reqStream.Write(fileData, 0, fileData.Length);

                    // نهاية body
                    byte[] trailer = Encoding.UTF8.GetBytes($"\r\n--{boundary}--\r\n");
                    reqStream.Write(trailer, 0, trailer.Length);
                }

                // الحصول على الرد
                string jsonText;
                using (WebResponse response = request.GetResponse())
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    jsonText = reader.ReadToEnd();
                }

                // عرض الـraw JSON أولاً، ثم نحاول استخراج الحقل prediction
                string display = $"Raw JSON: {jsonText}<br/>";

                try
                {
                    var obj = JObject.Parse(jsonText);
                    string pred = obj["prediction"]?.ToString() ?? "N/A";
                    display += $"Parsed prediction: {pred}";
                }
                catch (Exception parseEx)
                {
                    display += $"<span style='color:red;'>JSON parse error: {parseEx.Message}</span>";
                }

                ResultLabel.ForeColor = Color.Black;
                ResultLabel.Text = display;
            }
            catch (Exception ex)
            {
                ResultLabel.ForeColor = Color.Red;
                ResultLabel.Text = "Error: " + ex.Message;
            }
        }
    }
}
