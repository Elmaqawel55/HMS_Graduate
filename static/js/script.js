// Global variables
let selectedFile = null;
let isClassifying = false;

// DOM elements
const uploadArea = document.getElementById('uploadArea');
const fileInput = document.getElementById('fileInput');
const uploadContent = document.querySelector('.upload-content');
const filePreview = document.getElementById('filePreview');
const previewImage = document.getElementById('previewImage');
const fileName = document.getElementById('fileName');
const fileSize = document.getElementById('fileSize');
const removeFileBtn = document.getElementById('removeFile');
const classifyBtn = document.getElementById('classifyBtn');
const clearBtn = document.getElementById('clearBtn');
const loadingSection = document.getElementById('loadingSection');
const resultsSection = document.getElementById('resultsSection');
const errorSection = document.getElementById('errorSection');

// Initialize event listeners
document.addEventListener('DOMContentLoaded', function() {
    initializeEventListeners();
});

function initializeEventListeners() {
    // Upload area click to trigger file input
    uploadArea.addEventListener('click', () => {
        if (!selectedFile) {
            fileInput.click();
        }
    });

    // File input change
    fileInput.addEventListener('change', handleFileSelect);

    // Drag and drop events
    uploadArea.addEventListener('dragover', handleDragOver);
    uploadArea.addEventListener('dragleave', handleDragLeave);
    uploadArea.addEventListener('drop', handleDrop);

    // Button events
    classifyBtn.addEventListener('click', classifyImage);
    clearBtn.addEventListener('click', clearAll);
    removeFileBtn.addEventListener('click', removeFile);

    // Prevent default drag behaviors on the document
    document.addEventListener('dragover', (e) => e.preventDefault());
    document.addEventListener('drop', (e) => e.preventDefault());
}

function handleDragOver(e) {
    e.preventDefault();
    uploadArea.classList.add('dragover');
}

function handleDragLeave(e) {
    e.preventDefault();
    uploadArea.classList.remove('dragover');
}

function handleDrop(e) {
    e.preventDefault();
    uploadArea.classList.remove('dragover');
    
    const files = e.dataTransfer.files;
    if (files.length > 0) {
        const file = files[0];
        validateAndSetFile(file);
    }
}

function handleFileSelect(e) {
    const file = e.target.files[0];
    if (file) {
        validateAndSetFile(file);
    }
}

function validateAndSetFile(file) {
    // Clear previous results
    clearResults();

    // Validate file type
    const allowedTypes = ['image/png', 'image/jpeg', 'image/jpg'];
    if (!allowedTypes.includes(file.type)) {
        showError('Invalid file type. Please upload PNG or JPEG images only.');
        return;
    }

    // Validate file size (16MB max)
    const maxSize = 16 * 1024 * 1024;
    if (file.size > maxSize) {
        showError('File too large. Maximum file size is 16MB.');
        return;
    }

    // Set the selected file
    selectedFile = file;
    displayFilePreview(file);
    updateButtonStates();
}

function displayFilePreview(file) {
    // Hide upload content and show preview
    uploadContent.style.display = 'none';
    filePreview.style.display = 'flex';

    // Set file info
    fileName.textContent = `File: ${file.name}`;
    fileSize.textContent = `Size: ${formatFileSize(file.size)}`;

    // Create image preview
    const reader = new FileReader();
    reader.onload = function(e) {
        previewImage.src = e.target.result;
    };
    reader.readAsDataURL(file);

    // Add animation
    filePreview.classList.add('fade-in');
}

function removeFile() {
    selectedFile = null;
    fileInput.value = '';
    
    // Show upload content and hide preview
    uploadContent.style.display = 'block';
    filePreview.style.display = 'none';
    
    // Clear preview
    previewImage.src = '';
    fileName.textContent = '';
    fileSize.textContent = '';
    
    updateButtonStates();
    clearResults();
}

function updateButtonStates() {
    const hasFile = selectedFile !== null;
    classifyBtn.disabled = !hasFile || isClassifying;
    clearBtn.disabled = !hasFile || isClassifying;
}

async function classifyImage() {
    if (!selectedFile || isClassifying) {
        return;
    }

    isClassifying = true;
    updateButtonStates();
    showLoading();

    try {
        // Create FormData for file upload
        const formData = new FormData();
        formData.append('image', selectedFile);

        // Send request to Flask backend
        const response = await fetch('/classify', {
            method: 'POST',
            body: formData
        });

        const result = await response.json();

        if (result.success) {
            showResults(result.prediction);
        } else {
            showError(result.error || 'Classification failed');
        }

    } catch (error) {
        console.error('Error during classification:', error);
        showError('Network error. Please check your connection and try again.');
    } finally {
        isClassifying = false;
        updateButtonStates();
        hideLoading();
    }
}

function showLoading() {
    clearResults();
    loadingSection.style.display = 'block';
    loadingSection.classList.add('fade-in');
}

function hideLoading() {
    loadingSection.style.display = 'none';
}

function showResults(prediction) {
    clearResults();
    
    // Set predicted class
    const predictedClass = document.getElementById('predictedClass');
    predictedClass.textContent = prediction.predicted_class;
    
    // Set confidence
    const confidenceValue = document.getElementById('confidenceValue');
    const confidencePercentage = (prediction.confidence * 100).toFixed(1);
    confidenceValue.textContent = `${confidencePercentage}% Confidence`;
    
    // Update confidence badge color based on confidence level
    const confidenceBadge = document.getElementById('confidenceBadge');
    if (prediction.confidence >= 0.8) {
        confidenceBadge.style.background = 'linear-gradient(135deg, #10b981 0%, #059669 100%)';
    } else if (prediction.confidence >= 0.6) {
        confidenceBadge.style.background = 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)';
    } else {
        confidenceBadge.style.background = 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)';
    }
    
    // Create probability bars
    createProbabilityBars(prediction.probabilities);
    
    // Show results section
    resultsSection.style.display = 'block';
    resultsSection.classList.add('fade-in');
}

function createProbabilityBars(probabilities) {
    const probabilityBars = document.getElementById('probabilityBars');
    probabilityBars.innerHTML = '';
    
    // Sort probabilities by value (highest first)
    const sortedProbs = Object.entries(probabilities).sort((a, b) => b[1] - a[1]);
    
    sortedProbs.forEach(([className, probability]) => {
        const percentage = (probability * 100).toFixed(1);
        
        const barContainer = document.createElement('div');
        barContainer.className = 'probability-bar';
        
        barContainer.innerHTML = `
            <div class="probability-label">
                <span class="class-name">${className}</span>
                <span class="percentage">${percentage}%</span>
            </div>
            <div class="probability-progress">
                <div class="probability-fill" style="width: 0%"></div>
            </div>
        `;
        
        probabilityBars.appendChild(barContainer);
        
        // Animate the progress bar
        setTimeout(() => {
            const fill = barContainer.querySelector('.probability-fill');
            fill.style.width = `${percentage}%`;
        }, 100);
    });
}

function showError(message) {
    clearResults();
    
    const errorMessage = document.getElementById('errorMessage');
    errorMessage.textContent = message;
    
    errorSection.style.display = 'block';
    errorSection.classList.add('fade-in');
}

function clearResults() {
    // Hide all result sections
    loadingSection.style.display = 'none';
    resultsSection.style.display = 'none';
    errorSection.style.display = 'none';
    
    // Clear content
    document.getElementById('predictedClass').textContent = '';
    document.getElementById('confidenceValue').textContent = '';
    document.getElementById('probabilityBars').innerHTML = '';
    document.getElementById('errorMessage').textContent = '';
}

function clearAll() {
    removeFile();
    clearResults();
}

function formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

// Utility function for clearing results (can be called from HTML)
window.clearResults = clearResults;

// Add some visual feedback for better UX
document.addEventListener('DOMContentLoaded', function() {
    // Add hover effects to buttons
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(button => {
        button.addEventListener('mouseenter', function() {
            if (!this.disabled) {
                this.classList.add('pulse');
            }
        });
        
        button.addEventListener('mouseleave', function() {
            this.classList.remove('pulse');
        });
    });
    
    // Add loading animation to the upload area when processing
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.target.id === 'loadingSection' && 
                mutation.target.style.display === 'block') {
                uploadArea.style.opacity = '0.7';
                uploadArea.style.pointerEvents = 'none';
            } else if (mutation.target.id === 'loadingSection' && 
                       mutation.target.style.display === 'none') {
                uploadArea.style.opacity = '1';
                uploadArea.style.pointerEvents = 'auto';
            }
        });
    });
    
    observer.observe(loadingSection, {
        attributes: true,
        attributeFilter: ['style']
    });
});

// Console log for debugging
console.log('Brain Tumor Classification Interface Loaded');
console.log('API Endpoint: /classify');
console.log('Supported formats: PNG, JPEG');
console.log('Max file size: 16MB');
