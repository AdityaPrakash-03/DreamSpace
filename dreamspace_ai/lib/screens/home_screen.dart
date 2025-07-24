
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/style_card.dart';
import '../widgets/image_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('DreamSpace AI', style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: appProvider.originalImage == null
                      ? const UploadPlaceholder()
                      : ImageDisplay(
                          originalImage: appProvider.originalImage!,
                          styledImageProvider: appProvider.styledImageProvider,
                          sliderValue: appProvider.sliderValue,
                          onSliderChanged: (value) => appProvider.setSliderValue(value),
                          onTap: (position, size) => appProvider.shopTheLook(position, size, context),
                        ),
                ),
                if (appProvider.isShopping)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                const SizedBox(height: 20),
                const StyleSelector(),
                const SizedBox(height: 20),
                if (appProvider.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton.icon(
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Apply Style'),
                    onPressed: appProvider.originalImage == null ? null : () => appProvider.applyStyle(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UploadPlaceholder extends StatelessWidget {
  const UploadPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700, width: 2, style: BorderStyle.solid),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text('Upload a photo of your room', style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Select Image'),
              onPressed: () => Provider.of<AppProvider>(context, listen: false).pickImage(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StyleSelector extends StatelessWidget {
  const StyleSelector({super.key});
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final List<Map<String, dynamic>> styles = [
      {'name': 'Minimalist', 'icon': Icons.all_out},
      {'name': 'Industrial', 'icon': Icons.factory_outlined},
      {'name': 'Bohemian', 'icon': Icons.self_improvement_outlined},
      {'name': 'Art Deco', 'icon': Icons.theater_comedy_outlined},
      {'name': 'Coastal', 'icon': Icons.waves_outlined},
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: styles.length,
        itemBuilder: (context, index) {
          final style = styles[index];
          return StyleCard(
            styleName: style['name'],
            icon: style['icon'],
            isSelected: appProvider.selectedStyle == style['name'],
            onTap: () => appProvider.setSelectedStyle(style['name']),
          );
        },
      ),
    );
  }
}
