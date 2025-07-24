
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../widgets/product_bottom_sheet.dart';

class AppProvider extends ChangeNotifier {
  File? _originalImage;
  ImageProvider? _styledImageProvider;
  bool _isLoading = false;
  String _selectedStyle = 'Minimalist';
  double _sliderValue = 0.5;
  List<Product> _foundProducts = [];
  bool _isShopping = false;

  final String _backendUrl = 'http://192.168.169.50:5000'; // <-- MAKE SURE YOUR IP IS CORRECT

  // Getters
  File? get originalImage => _originalImage;
  ImageProvider? get styledImageProvider => _styledImageProvider;
  bool get isLoading => _isLoading;
  String get selectedStyle => _selectedStyle;
  double get sliderValue => _sliderValue;
  List<Product> get foundProducts => _foundProducts;
  bool get isShopping => _isShopping;

  // --- Methods from before ---
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      _originalImage = File(pickedFile.path);
      _styledImageProvider = null;
      _foundProducts = [];
      notifyListeners();
    }
  }

  void setSelectedStyle(String style) {
    _selectedStyle = style;
    notifyListeners();
  }

  void setSliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  // --- UPDATED applyStyle with DEBUGGING ---
  Future<void> applyStyle() async {
    if (_originalImage == null) return;
    _isLoading = true;
    notifyListeners();

    final url = '$_backendUrl/generate-style';
    print('--- APPLYING STYLE ---');
    print('Attempting to send request to: $url');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['style'] = _selectedStyle;
      request.files.add(await http.MultipartFile.fromPath('image', _originalImage!.path));
      
      print('Request prepared for style: $_selectedStyle. Sending...');

      var response = await request.send();
      
      print('Request sent. Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Success! Reading image bytes from response.');
        final responseBytes = await response.stream.toBytes();
        _styledImageProvider = MemoryImage(responseBytes);
        print('Image provider created successfully.');
      } else {
        print('--- BACKEND ERROR ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${await response.stream.bytesToString()}');
        _styledImageProvider = null;
      }
    } catch (e) {
      print('--- FLUTTER NETWORK ERROR ---');
      print('An error occurred while sending the request: $e');
      _styledImageProvider = null;
    } finally {
      print('--- FINISHING APPLY STYLE ---');
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- NEW METHOD FOR SHOP THE LOOK ---
  Future<void> shopTheLook(Offset localPosition, Size imageSize, BuildContext context) async {
    _isShopping = true;
    notifyListeners();

    try {
      final url = '$_backendUrl/shop-the-look';
      print('Calling Shop the Look at: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'x': localPosition.dx,
          'y': localPosition.dy,
          'width': imageSize.width,
          'height': imageSize.height,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> productJson = json.decode(response.body);
        _foundProducts = productJson.map((json) => Product.fromJson(json)).toList();
        print('Found ${_foundProducts.length} products.');
        
        // Show the results in a bottom sheet
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color(0xFF1E1E1E),
          builder: (context) => ProductBottomSheet(products: _foundProducts),
        );

      } else {
        print('Shop the Look Error: ${response.statusCode}');
        _foundProducts = [];
      }
    } catch (e) {
      print('Network Error (Shop the Look): $e');
      _foundProducts = [];
    } finally {
      _isShopping = false;
      notifyListeners();
    }
  }
}