# 🛋️✨ DreamSpace AI: Virtual Interior Design Stylist

DreamSpace AI is a mobile application that allows users to take a picture of their room and instantly redecorate it in various interior design styles using AI. Users can also tap on generated items to find and shop for similar products online.

This repository contains the complete source code for the **Flutter frontend** and the **Python (Flask) backend**.

---

## ✨ Features

- 📸 **Upload & Style**: Select an image of your room from your gallery or camera.
- 🎨 **AI-Powered Redesign**: Choose from multiple interior design styles (e.g., Minimalist, Industrial, Bohemian) to instantly visualize a new look.
- ↔️ **Before & After Slider**: Easily compare the original photo with the AI-generated design.
- 🛍️ **Shop the Look**: Tap on furniture or decor in the redesigned image to discover and shop for similar items from online retailers.
- 📱 **Cross-Platform**: Built with Flutter for a seamless experience on both Android and iOS.

---

## 🛠️ Tech Stack

### Frontend (Mobile App)
- **Framework**: Flutter  
- **State Management**: Provider  
- **HTTP Client**: `http`  
- **Image Handling**: `image_picker`  
- **URL Handling**: `url_launcher`  

### Backend (Server)
- **Framework**: Python with Flask  
- **Image Processing (Simulation)**: Pillow  
- **AI Models (Conceptual)**:
  - Image-to-Image Generation: *Stable Diffusion with ControlNet*
  - Object Recognition: *Multimodal Vision LLM like Gemini*

---

## 🚀 Setup and Installation

### 1. Backend Setup (Python)

Follow the steps below to get the Flask server running:

```bash
# Navigate to the backend directory
cd dreamspace_backend

# Create and activate a virtual environment
python -m venv venv

# On Windows
.\venv\Scripts\activate

# On macOS/Linux
source venv/bin/activate

# Install required packages
pip install -r requirements.txt

# If requirements.txt doesn't exist:
pip install Flask Pillow

# Run the Flask server
python app.py
The server will start on http://0.0.0.0:5000

2. Frontend Setup (Flutter)
Now set up the mobile application:

bash
Copy
Edit
# Navigate to the frontend directory
cd dreamspace_ai

# Get all Flutter dependencies
flutter pub get
🔧 Configure the Backend IP
Open lib/providers/app_provider.dart and update the _backendUrl variable with your computer’s local IP address.

dart
Copy
Edit
// Example
final String _backendUrl = "http://192.168.x.x:5000";
bash
Copy
Edit
# Run the app on an emulator or connected device
flutter run
📂 Project Structure
bash
Copy
Edit
dreamspace_ai/           # Flutter Frontend
dreamspace_backend/      # Python Flask Backend