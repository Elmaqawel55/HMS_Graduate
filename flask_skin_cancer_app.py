from flask import Flask, request, jsonify, render_template_string
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import img_to_array, load_img
import numpy as np
import base64
import io
from PIL import Image


# Load model and class names
model = load_model("./my_model.h5")
class_names = ['akiec', 'bcc', 'bkl', 'df', 'mel', 'nv', 'vasc']

# Full class name descriptions
class_descriptions = {
    'akiec': 'Actinic Keratoses and Intraepithelial Carcinoma',
    'bcc': 'Basal Cell Carcinoma',
    'bkl': 'Benign Keratosis-like Lesions',
    'df': 'Dermatofibroma',
    'mel': 'Melanoma',
    'nv': 'Melanocytic Nevi',
    'vasc': 'Vascular Lesions'
}

app = Flask(__name__)

# HTML template for home page
HOME_TEMPLATE = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skin Cancer Classification</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .upload-section {
            border: 2px dashed #ccc;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            margin-bottom: 20px;
            background-color: #fafafa;
        }
        .file-input {
            margin: 20px 0;
        }
        input[type="file"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
        .info-section {
            margin-top: 30px;
            padding: 20px;
            background-color: #e7f3ff;
            border-radius: 5px;
        }
        .class-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 10px;
            margin-top: 15px;
        }
        .class-item {
            background-color: white;
            padding: 10px;
            border-radius: 5px;
            border-left: 4px solid #4CAF50;
        }
        .class-code {
            font-weight: bold;
            color: #333;
        }
        .warning {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔬 Skin Cancer Classification System</h1>
        
        <div class="warning">
            <strong>⚠️ Medical Disclaimer:</strong> This tool is for educational purposes only and should not be used for actual medical diagnosis. Always consult with a qualified healthcare professional for medical advice.
        </div>

        <div class="upload-section">
            <h2>Upload Image for Analysis</h2>
            <p>Select a skin lesion image to classify</p>
            
            <form action="/predict" method="post" enctype="multipart/form-data">
                <div class="file-input">
                    <input type="file" name="image" accept="image/*" required>
                </div>
                <button type="submit" class="submit-btn">🔍 Analyze Image</button>
            </form>
        </div>

        <div class="info-section">
            <h3>📋 Classification Categories</h3>
            <p>This system can classify skin lesions into the following categories:</p>
            <div class="class-list">
                {% for code, description in class_descriptions.items() %}
                <div class="class-item">
                    <div class="class-code">{{ code.upper() }}</div>
                    <div>{{ description }}</div>
                </div>
                {% endfor %}
            </div>
        </div>

        <div class="info-section">
            <h3>💡 How to Use</h3>
            <ol>
                <li>Click "Choose File" to select an image from your device</li>
                <li>Select a clear image of a skin lesion</li>
                <li>Click "Analyze Image" to get the classification result</li>
                <li>View the predicted class and confidence score</li>
            </ol>
        </div>
    </div>
</body>
</html>
'''

# HTML template for results page
RESULT_TEMPLATE = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classification Result</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .result-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .uploaded-image {
            max-width: 300px;
            max-height: 300px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .prediction {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .confidence {
            font-size: 18px;
            color: #7f8c8d;
            margin-bottom: 15px;
        }
        .description {
            background-color: #e8f5e8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 16px;
            border-left: 4px solid #4CAF50;
        }
        .confidence-bar {
            width: 100%;
            height: 20px;
            background-color: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }
        .confidence-fill {
            height: 100%;
            background: linear-gradient(90deg, #4CAF50, #8BC34A);
            transition: width 0.5s ease;
        }
        .back-btn {
            background-color: #2196F3;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .back-btn:hover {
            background-color: #1976D2;
        }
        .warning {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔬 Classification Result</h1>
        
        <div class="warning">
            <strong>⚠️ Medical Disclaimer:</strong> This result is for educational purposes only. Please consult a healthcare professional for proper medical diagnosis.
        </div>

        <div class="result-section">
            {% if image_data %}
            <img src="data:image/jpeg;base64,{{ image_data }}" alt="Uploaded Image" class="uploaded-image">
            {% endif %}
            
            <div class="prediction">
                Predicted Class: {{ predicted_class.upper() }}
            </div>
            
            <div class="description">
                <strong>{{ class_description }}</strong>
            </div>
            
            <div class="confidence">
                Confidence: {{ "%.2f"|format(confidence * 100) }}%
            </div>
            
            <div class="confidence-bar">
                <div class="confidence-fill" style="width: {{ confidence * 100 }}%"></div>
            </div>
        </div>

        <div style="text-align: center;">
            <a href="/" class="back-btn">🔙 Analyze Another Image</a>
        </div>
    </div>
</body>
</html>
'''

@app.route('/')
def home():
    return render_template_string(HOME_TEMPLATE, class_descriptions=class_descriptions)

@app.route('/predict', methods=['GET', 'POST'])
def predict():
    if request.method == 'GET':
        return jsonify({
            'message': 'Send a POST request with an image file to this endpoint',
            'usage': 'Use the form at / to upload an image'
        })
    
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400
    
    file = request.files['image']
    
    if file.filename == '':
        return jsonify({'error': 'No image selected'}), 400
    
    try:
        # Load and preprocess the image
        img = load_img(io.BytesIO(file.read()), target_size=(71, 71))
        img_array = img_to_array(img) / 255.0
        img_array = np.expand_dims(img_array, axis=0)
        
        # Make prediction
        preds = model.predict(img_array)
        pred_idx = np.argmax(preds[0])
        pred_class = class_names[pred_idx]
        confidence = float(preds[0][pred_idx])
        
        # Convert image to base64 for display
        file.seek(0)  # Reset file pointer
        img_pil = Image.open(file)
        img_pil = img_pil.convert('RGB')
        img_buffer = io.BytesIO()
        img_pil.save(img_buffer, format='JPEG')
        img_data = base64.b64encode(img_buffer.getvalue()).decode()
        
        # Check if request wants JSON response (API call)
        if request.headers.get('Accept') == 'application/json':
            return jsonify({
                'predicted_class': pred_class,
                'confidence': confidence,
                'description': class_descriptions.get(pred_class, 'Unknown')
            })
        
        # Return HTML response for browser
        return render_template_string(
            RESULT_TEMPLATE,
            predicted_class=pred_class,
            confidence=confidence,
            class_description=class_descriptions.get(pred_class, 'Unknown'),
            image_data=img_data
        )
        
    except Exception as e:
        if request.headers.get('Accept') == 'application/json':
            return jsonify({'error': str(e)}), 500
        
        return f'''
        <html>
        <head><title>Error</title></head>
        <body>
            <h1>Error Processing Image</h1>
            <p>Error: {str(e)}</p>
            <a href="/">← Go Back</a>
        </body>
        </html>
        ''', 500

@app.route('/api/predict', methods=['POST'])
def api_predict():
    """Pure API endpoint for programmatic access"""
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400
    
    file = request.files['image']
    
    if file.filename == '':
        return jsonify({'error': 'No image selected'}), 400
    
    try:
        img = load_img(file, target_size=(71, 71))
        img_array = img_to_array(img) / 255.0
        img_array = np.expand_dims(img_array, axis=0)
        
        preds = model.predict(img_array)
        pred_idx = np.argmax(preds[0])
        pred_class = class_names[pred_idx]
        confidence = float(preds[0][pred_idx])
        
        return jsonify({
            'predicted_class': pred_class,
            'confidence': confidence,
            'description': class_descriptions.get(pred_class, 'Unknown'),
            'all_predictions': {
                class_names[i]: float(preds[0][i]) for i in range(len(class_names))
            }
        })
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    print("Starting Skin Cancer Classification Server...")
    print("Open your browser and go to: http://localhost:5000")
    app.run(debug=True, host='0.0.0.0', port=5000)