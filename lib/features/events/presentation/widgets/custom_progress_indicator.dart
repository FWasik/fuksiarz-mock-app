import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double time;

  const CustomProgressIndicator({Key? key, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: LinearProgressIndicator(
          value: time,
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
