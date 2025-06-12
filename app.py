from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
import os
from model import predict_brain_tumor, validate_image_format

app = Flask(__name__)
CORS(app)  # Enable CORS for cross-origin requests

# Configure upload settings
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB max file size

@app.route('/')
def index():
    """Serve the main page"""
    return render_template('index.html')

@app.route('/classify', methods=['POST'])
def classify_image():
    """API endpoint for brain tumor classification"""
    try:
        # Check if image file was uploaded
        if 'image' not in request.files:
            return jsonify({
                'error': 'No image file provided',
                'success': False
            }), 400
        
        file = request.files['image']
        
        # Check if file was selected
        if file.filename == '':
            return jsonify({
                'error': 'No file selected',
                'success': False
            }), 400
        
        # Validate file format
        if not validate_image_format(file.filename):
            return jsonify({
                'error': 'Invalid file format. Please upload PNG or JPEG images only.',
                'success': False
            }), 400
        
        # Read image bytes
        image_bytes = file.read()
        
        # Check file size
        if len(image_bytes) == 0:
            return jsonify({
                'error': 'Empty file uploaded',
                'success': False
            }), 400
        
        # Perform classification
        result = predict_brain_tumor(image_bytes)
        
        # Add success flag and metadata
        response = {
            'success': True,
            'prediction': result,
            'filename': file.filename,
            'file_size': len(image_bytes)
        }
        
        return jsonify(response), 200
        
    except Exception as e:
        print(f"Error in classify_image: {str(e)}")
        return jsonify({
            'error': f'Classification failed: {str(e)}',
            'success': False
        }), 500

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'message': 'Brain Tumor Classification API is running'
    }), 200

@app.errorhandler(413)
def file_too_large(error):
    """Handle file size exceeded error"""
    return jsonify({
        'error': 'File too large. Maximum file size is 16MB.',
        'success': False
    }), 413

@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors"""
    return jsonify({
        'error': 'Endpoint not found',
        'success': False
    }), 404

@app.errorhandler(500)
def internal_error(error):
    """Handle internal server errors"""
    return jsonify({
        'error': 'Internal server error',
        'success': False
    }), 500

if __name__ == '__main__':
    print("Starting Brain Tumor Classification Server...")
    print("Server will be available at: http://localhost:5000")
    print("API endpoint: http://localhost:5000/classify")
    print("Health check endpoint: http://localhost:5000/health")
    
    # Run the Flask app
    app.run(
        host='0.0.0.0',
        port=5000,
        debug=True,
        use_reloader=False  # Disable reloader to avoid model loading issues
    )
