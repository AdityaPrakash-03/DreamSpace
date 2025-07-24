
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product.dart';

class ProductBottomSheet extends StatelessWidget {
  final List<Product> products;

  const ProductBottomSheet({super.key, required this.products});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Could not launch the URL
      print('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shop the Look',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (products.isEmpty)
            const Center(child: Text("No products found for this area."))
          else
            ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        product.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.image_not_supported, size: 60),
                      ),
                    ),
                    title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(product.price, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                    trailing: ElevatedButton(
                      onPressed: () => _launchURL(product.purchaseUrl),
                      child: const Text('Buy Now'),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
