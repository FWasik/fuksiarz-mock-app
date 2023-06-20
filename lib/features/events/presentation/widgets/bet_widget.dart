import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';

class BetWidget extends StatelessWidget {
  final Outcome outcome;

  const BetWidget({Key? key, required this.outcome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // return Container(
    //   height: height / 17,
    //   padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     border: Border.all(width: 0.8, color: Colors.grey),
    //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //   ),
    //   child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Text(
    //           outcome.outcomeName,
    //           style: TextStyle(fontSize: 12),
    //         ),
    //         Text(
    //           outcome.outcomeOdds.toString(),
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //         )
    //       ]),
    // );

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(color: Colors.grey, width: 0.8)),
      ),
      child: Column(
        children: [
          SizedBox(
            width: width / 7,
            child: Center(
              child: Text(
                outcome.outcomeName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            outcome.outcomeOdds.toString(),
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      ),
    );
  }
}
