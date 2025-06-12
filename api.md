



## Base URL

```
http://localhost:5000
```

## Endpoints

### 1. Health Check

Check if the API is running and healthy.

**Endpoint:** `GET /health`

**Response:**
```json
{
  "status": "healthy",
  "message": "Brain Tumor Classification API is running"
}
```

**HTTP Status Codes:**
- `200 OK` - API is running normally

---

### 2. Classify Brain Tumor

Upload an MRI image for brain tumor classification.

**Endpoint:** `POST /classify`

**Content-Type:** `multipart/form-data`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `image` | File | Yes | MRI image file (PNG or JPEG format) |

**File Requirements:**
- **Supported formats:** PNG, JPEG, JPG
- **Maximum file size:** 16MB
- **Recommended:** High-resolution MRI scans for better accuracy

**Example Request (cURL):**
```bash
curl -X POST \
  http://localhost:5000/classify \
  -H 'Content-Type: multipart/form-data' \
  -F 'image=@/path/to/mri_scan.jpg'
```

**Example Request (JavaScript Fetch):**
```javascript
const formData = new FormData();
formData.append('image', imageFile);

fetch('http://localhost:5000/classify', {
  method: 'POST',
  body: formData
})
.then(response => response.json())
.then(data => console.log(data));
```

**Example Request (C# HttpClient):**
```csharp
using var client = new HttpClient();
using var content = new MultipartFormDataContent();
using var fileContent = new ByteArrayContent(imageBytes);

fileContent.Headers.ContentType = MediaTypeHeaderValue.Parse("image/jpeg");
content.Add(fileContent, "image", "mri_scan.jpg");

var response = await client.PostAsync("http://localhost:5000/classify", content);
var result = await response.Content.ReadAsStringAsync();
```

**Successful Response:**
```json
{
  "success": true,
  "prediction": {
    "predicted_class": "glioma",
    "confidence": 0.8567,
    "probabilities": {
      "glioma": 0.8567,
      "meningioma": 0.0892,
      "notumor": 0.0321,
      "pituitary": 0.0220
    }
  },
  "filename": "mri_scan.jpg",
  "file_size": 2048576
}
```

**Response Fields:**

| Field | Type | Description |
|-------|------|-------------|
| `success` | Boolean | Indicates if the classification was successful |
| `prediction.predicted_class` | String | The predicted tumor type |
| `prediction.confidence` | Float | Confidence score for the predicted class (0-1) |
| `prediction.probabilities` | Object | Probability scores for all classes (0-1) |
| `filename` | String | Original filename of the uploaded image |
| `file_size` | Integer | Size of the uploaded file in bytes |

**Class Labels:**

| Label | Description |
|-------|-------------|
| `glioma` | Glioma tumor |
| `meningioma` | Meningioma tumor |
| `pituitary` | Pituitary tumor |
| `notumor` | No tumor detected |

**Error Response:**
```json
{
  "success": false,
  "error": "Invalid file format. Please upload PNG or JPEG images only."
}
```

**HTTP Status Codes:**
- `200 OK` - Classification successful
- `400 Bad Request` - Invalid request (missing file, invalid format, etc.)
- `413 Payload Too Large` - File size exceeds 16MB limit
- `500 Internal Server Error` - Server error during classification

---



## Integration Examples

### ASP.NET Core Integration

```csharp
public class BrainTumorClassificationService
{
    private readonly HttpClient _httpClient;
    private const string ApiBaseUrl = "http://localhost:5000";

    public BrainTumorClassificationService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<ClassificationResult> ClassifyImageAsync(byte[] imageBytes, string fileName)
    {
        using var content = new MultipartFormDataContent();
        using var fileContent = new ByteArrayContent(imageBytes);
        
        fileContent.Headers.ContentType = MediaTypeHeaderValue.Parse("image/jpeg");
        content.Add(fileContent, "image", fileName);

        var response = await _httpClient.PostAsync($"{ApiBaseUrl}/classify", content);
        var jsonResponse = await response.Content.ReadAsStringAsync();
        
        return JsonSerializer.Deserialize<ClassificationResult>(jsonResponse);
    }
}

public class ClassificationResult
{
    public bool Success { get; set; }
    public string Error { get; set; }
    public PredictionResult Prediction { get; set; }
    public string Filename { get; set; }
    public long FileSize { get; set; }
}

public class PredictionResult
{
    public string PredictedClass { get; set; }
    public double Confidence { get; set; }
    public Dictionary<string, double> Probabilities { get; set; }
}
```

### Node.js Integration

```javascript
const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');

async function classifyImage(imagePath) {
  const form = new FormData();
  form.append('image', fs.createReadStream(imagePath));

  try {
    const response = await axios.post('http://localhost:5000/classify', form, {
      headers: {
        ...form.getHeaders(),
      },
    });
    
    return response.data;
  } catch (error) {
    console.error('Classification error:', error.response?.data || error.message);
    throw error;
  }
}
```
