import 'dart:ui';
import 'package:flutter/material.dart';

class BookRatingCoinRow extends StatelessWidget {
  final int coin;
  final double rating;
  final String? imageUrl;

  const BookRatingCoinRow({
    super.key,
    required this.coin,
    required this.rating,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Opacity(
              opacity: 0.5,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.book, size: 100),
                    ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Container(color: Colors.black.withOpacity(0.44)),
          ),
          Positioned(
            top: 100,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.37),
                        blurRadius: 6,
                        offset: const Offset(3, 4),
                      ),
                    ],
                  ),
                  child: imageUrl != null
                      ? Image.network(imageUrl!, height: 200)
                      : Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.book, size: 100),
                        ),
                ),
                Positioned(
                  top: -12,
                  left: -20,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          bottom: -12,
                          right: 0,
                          child: Image.asset(
                            'assets/images/library/right_tail.png',
                            width: 38.68,
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/library/coin.png',
                              width: 20,
                            ),
                            const SizedBox(width: 4),
                            Text('$coin'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -24,
                  bottom: -12,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star,
                                color: Colors.blue, size: 18),
                            const SizedBox(width: 4),
                            Text(rating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
