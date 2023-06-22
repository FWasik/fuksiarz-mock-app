import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isClicked;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.isClicked,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: isClicked
              ? Colors.white
              : const Color.fromARGB(255, 228, 228, 228),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
