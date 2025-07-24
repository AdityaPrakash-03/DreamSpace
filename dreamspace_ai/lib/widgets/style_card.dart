// A reusable card widget for selecting a design style.

import 'package:flutter/material.dart';

class StyleCard extends StatelessWidget {
  final String styleName;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const StyleCard({
    super.key,
    required this.styleName,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade700,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white),
            const SizedBox(height: 8),
            Text(
              styleName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
