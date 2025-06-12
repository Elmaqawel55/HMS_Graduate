import torch
import torch.nn as nn
from torchvision import transforms
from PIL import Image
import io
import os

class BrainTumorCNN(nn.Module):
    def __init__(self, num_classes=4):
        super(BrainTumorCNN, self).__init__()

        self.relu = nn.ReLU()
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2)
        self.dropout = nn.Dropout(0.5)

        # Conv Block 1
        self.conv1 = nn.Conv2d(3, 32, kernel_size=3, padding=1)   # (B, 32, 224, 224)

        # Conv Block 2
        self.conv2 = nn.Conv2d(32, 64, kernel_size=3, padding=1)  # (B, 64, 112, 112)

        # Conv Block 3
        self.conv3 = nn.Conv2d(64, 128, kernel_size=3, padding=1) # (B, 128, 56, 56)

        # Conv Block 4
        self.conv4 = nn.Conv2d(128, 256, kernel_size=3, padding=1) # (B, 256, 28, 28)

        # Conv Block 5
        self.conv5 = nn.Conv2d(256, 256, kernel_size=3, padding=1) # (B, 256, 14, 14)

        # Final shape after pool: (B, 256, 7, 7)
        self.flatten = nn.Flatten()
        self.fc1 = nn.Linear(256 * 7 * 7, 512)
        self.fc2 = nn.Linear(512, num_classes)

    def forward(self, x):
        x = self.pool(self.relu(self.conv1(x)))  # (B, 32, 112, 112)
        x = self.pool(self.relu(self.conv2(x)))  # (B, 64, 56, 56)
        x = self.pool(self.relu(self.conv3(x)))  # (B, 128, 28, 28)
        x = self.pool(self.relu(self.conv4(x)))  # (B, 256, 14, 14)
        x = self.pool(self.relu(self.conv5(x)))  # (B, 256, 7, 7)

        x = self.flatten(x)
        x = self.dropout(self.relu(self.fc1(x)))
        x = self.fc2(x)

        return x

# Class labels mapping
CATEGORIES = ['pituitary', 'notumor', 'meningioma', 'glioma']

# Image preprocessing transforms
test_transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

# Global model variable
model = None
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

def load_model():
    """Load the trained brain tumor classification model"""
    global model
    if model is None:
        try:
            # Initialize the model
            model = BrainTumorCNN(num_classes=4).to(device)
            
            # Load the saved weights from the current directory
            model_path = 'best_brain_tumor_model.pth'
            model.load_state_dict(torch.load(model_path, map_location=device))
            model.eval()
            print(f"Model loaded successfully on {device}")
        except Exception as e:
            print(f"Error loading model: {e}")
            raise e
    return model

def preprocess_image(image_bytes):
    """Preprocess image bytes for model inference"""
    try:
        # Open image from bytes
        image = Image.open(io.BytesIO(image_bytes))
        
        # Convert to RGB if necessary (handles RGBA, grayscale, etc.)
        if image.mode != 'RGB':
            image = image.convert('RGB')
        
        # Apply preprocessing transforms
        image_tensor = test_transform(image)
        
        # Add batch dimension
        image_tensor = image_tensor.unsqueeze(0).to(device)
        
        return image_tensor
    except Exception as e:
        print(f"Error preprocessing image: {e}")
        raise e

def predict_brain_tumor(image_bytes):
    """Perform brain tumor classification on image bytes"""
    try:
        # Load model if not already loaded
        model = load_model()
        
        # Preprocess the image
        image_tensor = preprocess_image(image_bytes)
        
        # Perform inference
        with torch.no_grad():
            outputs = model(image_tensor)
            probabilities = torch.softmax(outputs, dim=1)
            predicted_class = torch.argmax(probabilities, dim=1).item()
            confidence = probabilities[0][predicted_class].item()
        
        # Get the predicted label
        predicted_label = CATEGORIES[predicted_class]
        
        # Prepare result
        result = {
            'predicted_class': predicted_label,
            'confidence': float(confidence),
            'probabilities': {
                CATEGORIES[i]: float(probabilities[0][i]) 
                for i in range(len(CATEGORIES))
            }
        }
        
        return result
        
    except Exception as e:
        print(f"Error during prediction: {e}")
        raise e

def validate_image_format(filename):
    """Validate if the uploaded file has a supported format"""
    allowed_extensions = {'.png', '.jpg', '.jpeg'}
    file_extension = os.path.splitext(filename.lower())[1]
    return file_extension in allowed_extensions
