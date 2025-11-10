from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import HTMLResponse
from fastapi.middleware.cors import CORSMiddleware
import tensorflow as tf
import numpy as np
from PIL import Image
import io
import json
import base64
from typing import Dict, Any
import cv2

app = FastAPI(title="Medicinal Leaf Classifier API")

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True
)

# Load model
try:
    model = tf.keras.models.load_model('best_model.keras')
    print("✅ Model loaded successfully")
except Exception as e:
    print(f"❌ Error loading model: {e}")
    model = None

# Load knowledge database
try:
    with open('knowledge_db.json', 'r', encoding='utf-8') as f:
        knowledge_db = json.load(f)
    print("✅ Knowledge database loaded successfully")
except Exception as e:
    print(f"❌ Error loading knowledge database: {e}")
    knowledge_db = {}

# Class names (update these based on your model)
CLASS_NAMES = [
    'alpinia_galanga',
    'aristolochia_indica',
    'azadirachta_indica',
    'basella_alba',
    'calotropis_gigantea',
    'citrus_limon',
    'ficus_auriculata',
    'ficus_religiosa',
    'hibiscus_rosa_sinensis',
    'jasminum_sambac',
    'mangifera_indica',
    'mentha_arvensis',
    'moringa_oleifera',
    'muntingia_calabura',
    'murraya_koenigii',
    'nyctanthes_arbor_tristis',
    'ocimum_tenuiflorum',
    'piper_betle',
    'plectranthus_amboinicus',
    'psidium_guajava',
    'santalum_album',
    'syzygium_cumini',
    'terminalia_chebula',
    'trigonella_foenum_graecum',
    'vitex_negundo'
]

def preprocess_image(image_bytes: bytes) -> np.ndarray:
    """Preprocess image for model prediction"""
    try:
        # Convert bytes to PIL Image
        image = Image.open(io.BytesIO(image_bytes))
        
        # Convert to RGB if necessary
        if image.mode != 'RGB':
            image = image.convert('RGB')
        
        # Resize to model input size
        image = image.resize((224, 224))
        
        # Convert to numpy array and normalize
        img_array = np.array(image)
        img_array = img_array / 255.0
        
        # Add batch dimension
        img_array = np.expand_dims(img_array, axis=0)
        
        return img_array
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error preprocessing image: {str(e)}")

def generate_gradcam(model, img_array, class_idx, layer_name='mixed7'):
    """Generate Grad-CAM visualization"""
    try:
        # Create a model that outputs both predictions and feature maps
        grad_model = tf.keras.models.Model(
            inputs=model.input,
            outputs=[model.get_layer(layer_name).output, model.output]
        )
        
        with tf.GradientTape() as tape:
            conv_outputs, predictions = grad_model(img_array)
            loss = predictions[:, class_idx]
        
        # Compute gradients
        grads = tape.gradient(loss, conv_outputs)
        
        # Pool gradients
        pooled_grads = tf.reduce_mean(grads, axis=(0, 1, 2))
        
        # Weight feature maps
        conv_outputs = conv_outputs[0]
        heatmap = tf.reduce_sum(tf.multiply(pooled_grads, conv_outputs), axis=-1)
        
        # Normalize heatmap
        heatmap = tf.maximum(heatmap, 0) / tf.math.reduce_max(heatmap)
        heatmap = heatmap.numpy()
        
        # Resize heatmap to original image size
        heatmap = cv2.resize(heatmap, (224, 224))
        
        # Apply colormap
        heatmap = np.uint8(255 * heatmap)
        heatmap = cv2.applyColorMap(heatmap, cv2.COLORMAP_JET)
        
        # Original image
        original_img = np.uint8(255 * img_array[0])
        
        # Superimpose heatmap on original image
        superimposed_img = cv2.addWeighted(original_img, 0.6, heatmap, 0.4, 0)
        
        # Convert to base64
        _, buffer = cv2.imencode('.jpg', superimposed_img)
        gradcam_base64 = base64.b64encode(buffer).decode('utf-8')
        
        return gradcam_base64
    except Exception as e:
        print(f"⚠️ Grad-CAM generation failed: {e}")
        # Return blank image as fallback
        blank = np.zeros((224, 224, 3), dtype=np.uint8)
        _, buffer = cv2.imencode('.jpg', blank)
        return base64.b64encode(buffer).decode('utf-8')

@app.get("/", response_class=HTMLResponse)
async def root():
    html_content = """
    <html>
        <head>
            <title>Medicinal Leaf Classifier API</title>
            <style>
                body {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex-direction: column;
                    height: 100vh;
                    margin: 0;
                    background-color: #010101;
                    color: white;
                    font-family: Arial, sans-serif;
                }
                h1 {
                    font-size: 3em;
                    margin: 0;
                }
                p {
                    font-size: 2em;
                    margin: 10px 0;
                }
            </style>
        </head>
        <body>
            <h1>🍃 Medicinal Leaf Classifier</h1>
            <p>AI-Powered Leaf Classification with Explainable AI</p>
            <p style="font-size: 1.2em;">API is running! Visit <a href="/docs" style="color: #4CAF50;">/docs</a> for documentation.</p>
        </body>
    </html>
    """
    return HTMLResponse(content=html_content)

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    """
    Predict medicinal leaf type from uploaded image
    
    Returns:
    - predicted_class: The predicted leaf type
    - confidence: Confidence score (0-1)
    - top3: Top 3 predictions with probabilities
    - knowledge: Medicinal information about the leaf
    - gradcam_image_base64: Grad-CAM visualization as base64 string
    """
    if model is None:
        raise HTTPException(status_code=500, detail="Model not loaded")
    
    # Validate file type
    if not file.content_type or not file.content_type.startswith('image/'):
        raise HTTPException(status_code=400, detail="File must be an image")
    
    try:
        # Read image bytes
        image_bytes = await file.read()
        print(f"📥 Received image: {file.filename} ({len(image_bytes)} bytes)")
        
        # Preprocess image
        img_array = preprocess_image(image_bytes)
        
        # Make prediction
        predictions = model.predict(img_array, verbose=0)
        predicted_idx = np.argmax(predictions[0])
        confidence = float(predictions[0][predicted_idx])
        predicted_class = CLASS_NAMES[predicted_idx]
        
        print(f"🎯 Prediction: {predicted_class} (confidence: {confidence:.2%})")
        
        # Get top 3 predictions
        top3_indices = np.argsort(predictions[0])[-3:][::-1]
        top3 = [
            {
                "class": CLASS_NAMES[idx],
                "probability": float(predictions[0][idx])
            }
            for idx in top3_indices
        ]
        
        # Get knowledge information
        knowledge = knowledge_db.get(predicted_class, {
            "Medicinal Uses": "Information not available",
            "Active Compounds": "Information not available",
            "Precautions": "Information not available",
            "Sources": "Information not available"
        })
        
        # Generate Grad-CAM
        print("🔥 Generating Grad-CAM...")
        gradcam_base64 = generate_gradcam(model, img_array, predicted_idx)
        
        response = {
            "predicted_class": predicted_class,
            "confidence": confidence,
            "top3": top3,
            "knowledge": knowledge,
            "gradcam_image_base64": gradcam_base64
        }
        
        print("✅ Response prepared successfully")
        return response
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"❌ Prediction error: {e}")
        raise HTTPException(status_code=500, detail=f"Prediction failed: {str(e)}")

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "model_loaded": model is not None,
        "knowledge_db_loaded": len(knowledge_db) > 0,
        "num_classes": len(CLASS_NAMES)
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)