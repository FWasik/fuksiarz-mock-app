import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';

class BetButton extends StatelessWidget {
  final Outcome outcome;

  const BetButton({Key? key, required this.outcome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      height: 60,
      width: 65,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                outcome.outcomeName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Text(
              outcome.outcomeOdds.toString(),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
