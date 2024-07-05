import 'package:flutter/material.dart';

import 'package:la_barber/core/ui/styles/text_styles_typography.dart';

class ServicesDetailTile extends StatelessWidget {
  final String title;
  final String content;
  const ServicesDetailTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8), color: Colors.white),
            padding: const EdgeInsets.all(12),
            child: Text(
              content,
              style: AppTextStyles.titleLarge(),
            ),
          ),
        ],
      ),
    );
  }
}
