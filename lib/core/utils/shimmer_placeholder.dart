import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFeedPlaceholder extends StatelessWidget {
  const ShimmerFeedPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.cardColor;
    final highlightColor = baseColor.withOpacity(0.4);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: highlightColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 14, width: 100, color: highlightColor),
                          const SizedBox(height: 6),
                          Container(height: 12, width: 60, color: highlightColor),
                        ],
                      ),
                    ),
                    Container(height: 20, width: 20, color: highlightColor),
                  ],
                ),
                const SizedBox(height: 16),

                // Post text placeholder
                Container(height: 14, width: double.infinity, color: highlightColor),
                const SizedBox(height: 8),
                Container(height: 14, width: MediaQuery.of(context).size.width * 0.7, color: highlightColor),
                const SizedBox(height: 12),

                // Image placeholder
                Container(height: 200, width: double.infinity, color: highlightColor),
                const SizedBox(height: 12),

                // Actions row
                Row(
                  children: [
                    Container(height: 20, width: 20, color: highlightColor),
                    const SizedBox(width: 8),
                    Container(height: 12, width: 30, color: highlightColor),
                    const SizedBox(width: 16),
                    Container(height: 20, width: 20, color: highlightColor),
                    const SizedBox(width: 8),
                    Container(height: 12, width: 30, color: highlightColor),
                    const Spacer(),
                    Container(height: 20, width: 20, color: highlightColor),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
