
import os
from flask import Flask, request, send_file, jsonify
from PIL import Image, ImageOps, ImageEnhance
import io

# --- 1. SETUP ---
app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
GENERATED_FOLDER = 'generated'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(GENERATED_FOLDER, exist_ok=True)

# --- 2. AI SIMULATION LOGIC (VISUALIZER) ---
def apply_style_simulation(image_path, style):
    """
    Opens an image, applies a style filter, and returns the modified image object.
    """
    try:
        img = Image.open(image_path)
        print(f"Applying style: {style}")

        if style == 'Minimalist':
            processed_img = ImageOps.grayscale(img).convert('RGB')
        elif style == 'Industrial':
            sepia_filter = Image.new('RGB', img.size, (112, 66, 20))
            processed_img = Image.blend(img.convert('RGB'), sepia_filter, alpha=0.4)
        elif style == 'Bohemian':
            converter = ImageEnhance.Color(img)
            processed_img = converter.enhance(1.5)
        elif style == 'Art Deco':
            gold_filter = Image.new('RGB', img.size, (255, 215, 0))
            processed_img = Image.blend(img.convert('RGB'), gold_filter, alpha=0.3)
        elif style == 'Coastal':
            blue_filter = Image.new('RGB', img.size, (173, 216, 230))
            processed_img = Image.blend(img.convert('RGB'), blue_filter, alpha=0.2)
        else:
            processed_img = img.convert('RGB')
        return processed_img
    except Exception as e:
        print(f"Error applying style: {e}")
        return None

# --- 3. AI SIMULATION LOGIC (SHOP THE LOOK) ---
def shop_the_look_simulation(x, y, image_width, image_height):
    """
    Simulates identifying an object based on tap coordinates.
    Returns a list of mock products.
    """
    print(f"Identifying object at ({x}, {y}) in an image of size ({image_width}, {image_height})")

    # Normalize coordinates to be independent of image size
    norm_y = y / image_height

    # --- Mock Product Data ---
    # In a real app, this would come from a database or a retail API
    sofas = [
        {"product_name": "Modern Velvet Sofa", "price": "₹45,999", "image_url": "https://placehold.co/400x400/3498db/FFF?text=Velvet+Sofa", "purchase_link": "#"},
        {"product_name": "Classic Leather Couch", "price": "₹62,499", "image_url": "https://placehold.co/400x400/9b59b6/FFF?text=Leather+Couch", "purchase_link": "#"},
    ]
    lamps = [
        {"product_name": "Industrial Floor Lamp", "price": "₹7,899", "image_url": "https://placehold.co/400x400/f1c40f/000?text=Floor+Lamp", "purchase_link": "#"},
        {"product_name": "Minimalist Desk Lamp", "price": "₹3,200", "image_url": "https://placehold.co/400x400/e74c3c/FFF?text=Desk+Lamp", "purchase_link": "#"},
    ]
    art = [
        {"product_name": "Abstract Wall Art", "price": "₹4,500", "image_url": "https://placehold.co/400x400/2ecc71/FFF?text=Abstract+Art", "purchase_link": "#"},
    ]

    # --- Simple Logic based on tap position ---
    # If the user taps on the bottom 40% of the image, we assume it's a sofa.
    if norm_y > 0.6:
        return sofas
    # If the tap is in the upper-middle section, assume it's a lamp.
    elif 0.2 < norm_y <= 0.6:
        return lamps
    # Otherwise, assume it's wall art.
    else:
        return art

# --- 4. API ENDPOINTS ---
@app.route('/generate-style', methods=['POST'])
def generate_style():
    """ Handles the image upload, processing, and returns the styled image. """
    if 'image' not in request.files:
        return jsonify({"error": "No image file provided"}), 400
    image_file = request.files['image']
    style = request.form.get('style', 'Minimalist')
    if image_file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    if image_file:
        original_path = os.path.join(UPLOAD_FOLDER, image_file.filename)
        image_file.save(original_path)
        styled_image = apply_style_simulation(original_path, style)
        if styled_image:
            byte_arr = io.BytesIO()
            styled_image.save(byte_arr, format='JPEG')
            byte_arr.seek(0)
            return send_file(byte_arr, mimetype='image/jpeg', as_attachment=True, download_name='styled_image.jpg')
    return jsonify({"error": "An error occurred during processing"}), 500

@app.route('/shop-the-look', methods=['POST'])
def shop_the_look():
    """
    Handles a tap location, simulates object detection, and returns product data.
    """
    data = request.get_json()
    if not data:
        return jsonify({"error": "Invalid JSON data"}), 400

    # Get tap coordinates and image dimensions from the request
    x = data.get('x')
    y = data.get('y')
    image_width = data.get('width')
    image_height = data.get('height')

    if x is None or y is None or image_width is None or image_height is None:
        return jsonify({"error": "Missing coordinate or dimension data"}), 400

    # Get the mock product list from our simulation function
    products = shop_the_look_simulation(x, y, image_width, image_height)

    # Return the product list as a JSON response
    return jsonify(products)


# --- 5. RUN THE SERVER ---
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)