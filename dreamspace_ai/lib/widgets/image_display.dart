
import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final File originalImage;
  final ImageProvider? styledImageProvider;
  final double sliderValue;
  final ValueChanged<double> onSliderChanged;
  final Function(Offset, Size) onTap;

  const ImageDisplay({
    super.key,
    required this.originalImage,
    this.styledImageProvider,
    required this.sliderValue,
    required this.onSliderChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // Using a LayoutBuilder gives us the dimensions of the widget.
          child: LayoutBuilder(
            builder: (context, constraints) {
              final imageSize = Size(constraints.maxWidth, constraints.maxHeight);
              return GestureDetector(
                onTapDown: (details) {
                  // Only allow tapping if a styled image exists
                  if (styledImageProvider != null) {
                    onTap(details.localPosition, imageSize);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(originalImage, fit: BoxFit.cover),
                      if (styledImageProvider != null)
                        ClipPath(
                          clipper: _ImageClipper(clipFactor: sliderValue),
                          child: Image(image: styledImageProvider!, fit: BoxFit.cover),
                        ),
                      if (styledImageProvider != null)
                        const Center(
                          child: Icon(Icons.touch_app, color: Colors.white70, size: 50),
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (styledImageProvider != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Slider(
              value: sliderValue,
              onChanged: onSliderChanged,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }
}

class _ImageClipper extends CustomClipper<Path> {
  final double clipFactor;
  _ImageClipper({required this.clipFactor});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width * clipFactor, size.height));
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

