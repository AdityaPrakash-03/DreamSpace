DreamSpace AI: Virtual Interior Design Stylist 🛋️✨
DreamSpace AI is a mobile application that allows users to take a picture of their room and instantly redecorate it in various interior design styles using AI. Users can also tap on generated items to find and shop for similar products online.

This repository contains the complete source code for the Flutter frontend and the Python (Flask) backend.

Features
📸 Upload & Style: Select an image of your room from your gallery or camera.

🎨 AI-Powered Redesign: Choose from multiple interior design styles (e.g., Minimalist, Industrial, Bohemian) to instantly visualize a new look.

↔️ Before & After Slider: Easily compare the original photo with the AI-generated design.

🛍️ Shop the Look: Tap on furniture or decor in the redesigned image to discover and shop for similar items from online retailers.

📱 Cross-Platform: Built with Flutter for a seamless experience on both Android and iOS.

Tech Stack
This project is a full-stack application composed of a mobile frontend and a web backend.

Frontend (Mobile App)
Framework: Flutter

State Management: Provider

HTTP Client: http

Image Handling: image_picker

URL Handling: url_launcher

Backend (Server)
Framework: Python with Flask

Image Processing (Simulation): Pillow

AI Models (Conceptual):

Image-to-Image Generation: Stable Diffusion with ControlNet (for redesigning the room).

Object Recognition: A Multimodal Vision LLM like Gemini (for the "Shop the Look" feature).

Setup and Installation
To run this project locally, you will need to set up both the backend server and the frontend mobile app.

1. Backend Setup (Python)
First, get the server running.

# 1. Navigate to the backend directory
cd dreamspace_backend

# 2. Create and activate a virtual environment
python -m venv venv
# On Windows:
.\venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# 3. Install the required packages
pip install -r requirements.txt

# 4. Run the Flask server
python app.py

Note: If requirements.txt does not exist, run pip install Flask Pillow. The server will start on http://0.0.0.0:5000.

2. Frontend Setup (Flutter)
Next, set up the Flutter application.

# 1. Navigate to the frontend directory
cd dreamspace_ai

# 2. Get all the Flutter dependencies
flutter pub get

# 3. IMPORTANT: Configure the Backend IP Address
#    Open lib/providers/app_provider.dart and update the _backendUrl variable
#    with your computer's local IP address.

# 4. Run the app on an emulator or a connected device
flutter run
