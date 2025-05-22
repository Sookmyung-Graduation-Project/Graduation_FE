import 'package:flutter/material.dart';

class AudioCard extends StatelessWidget {
  final String title;
  final String date;

  const AudioCard({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFAC632),
            ),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'GyeonggiTitleLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff363535),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontFamily: 'GyeonggiTitleLight',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
