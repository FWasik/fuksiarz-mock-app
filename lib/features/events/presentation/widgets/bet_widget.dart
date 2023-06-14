import 'package:flutter/material.dart';

class BetWidget extends StatelessWidget {
  final String bet;
  final String rate;

  const BetWidget({Key? key, required this.bet, required this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: width / 8.5,
      height: height / 17,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.8, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          bet,
          style: TextStyle(fontSize: 12),
        ),
        Text(
          rate,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
