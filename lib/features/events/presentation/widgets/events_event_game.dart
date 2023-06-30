import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/bet_widget.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/custom_progress_indicator.dart';

class EventsEventGame extends StatelessWidget {
  final Event event;
  final EventGame eventGame;

  const EventsEventGame(
      {Key? key, required this.event, required this.eventGame})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> team_splitted = eventGame.eventName.split(" - ");
    String first_team = team_splitted[0];
    String second_team = team_splitted[1];

    int time = 45;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${eventGame.category3Name} ${event.eventDate}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 20,
                height: 30,
                color: Colors.red,
              )
            ],
          ),
          const Spacer(flex: 1),
          Row(
            children: [
              Text(
                event.eventTime,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              CustomProgressIndicator(time: time / 45),
              const Text(
                "111",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Spacer(flex: 2),
          Row(
            children: [
              Text(
                first_team + "\n" + second_team,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              if (event.eventType != 1) ...[
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 10.0),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side:
                              const BorderSide(color: Colors.grey, width: 0.8)),
                    ),
                    child: Text(
                      "DO WYDARZENIA".toString(),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
              ] else ...[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: eventGame.outcomes
                        .map(
                          (outcome) => BetWidget(outcome: outcome),
                        )
                        .toList(),
                  ),
                )
              ]
            ],
          )
        ]),
      ),
    );
  }
}
