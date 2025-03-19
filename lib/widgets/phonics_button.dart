import 'package:flutter/material.dart';
import 'package:phonics/screens/phonics_screen.dart';

class PhonicsButton extends StatelessWidget {
  const PhonicsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildButton(
      imageAsset: 'assets/images/abc_button_logo.png',
      color: const Color(0xffcebc62),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PhonicsScreen()),
        );
      },
    );
  }
}

Widget _buildButton({
  required String imageAsset,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 280,
      height: 195,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Image.asset(
          imageAsset,
          width: 278,
          height: 193,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
