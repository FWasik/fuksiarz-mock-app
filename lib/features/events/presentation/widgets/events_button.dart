import 'package:flutter/cupertino.dart';
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
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        style: OutlinedButton.styleFrom(
            primary: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor:
                isClicked ? Colors.white : Color.fromARGB(255, 228, 228, 228)),
      ),
    );
  }
}
