import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/bet_widget.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/custom_progress_indicator.dart';

class EventsFootball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    int time = 45;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: height / 6,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "el. Mistrzostw Swiata  16.06",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 20,
                height: 30,
                color: Colors.red,
              )
            ],
          ),
          Spacer(flex: 1),
          Row(
            children: [
              Text(
                "18:00",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              CustomProgressIndicator(time: time / 45),
              CustomProgressIndicator(time: (time - 45) / 45),
              Text(
                "111",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Spacer(flex: 2),
          Row(
            children: [
              Column(
                children: [
                  Text("Chelsea",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Arsenal",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                ],
              ),
              Spacer(flex: 14),
              BetWidget(bet: "1", rate: "1.20"),
              Spacer(flex: 1),
              BetWidget(bet: "X", rate: "2.20"),
              Spacer(flex: 1),
              BetWidget(bet: "2", rate: "4.20")
            ],
          )
        ]),
      ),
    );
  }
}
