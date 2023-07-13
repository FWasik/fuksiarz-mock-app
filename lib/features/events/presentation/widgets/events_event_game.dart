import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/common/events_base.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/bet_widget.dart';
import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/custom_progress_indicator.dart';

class EventsEventGame extends StatelessWidget {
  final SportCategory3Name subsubcategory;
  final EventBase event;
  final EventGame? eventGame;

  const EventsEventGame(
      {Key? key,
      required this.subsubcategory,
      required this.event,
      this.eventGame})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> teamSplitted = event.eventName.split(" - ");
    String firstTeam = teamSplitted[0];
    String secondTeam = teamSplitted[1];

    int time = 45;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${subsubcategory.name} ${event.eventDate}",
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
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firstTeam,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      secondTeam,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              if (event is Event)
                if ((event as Event).eventType != 1) ...[
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(13.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: const Text(
                        "DO WYDARZENIA",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: eventGame!.outcomes
                          .map(
                            (outcome) => BetButton(outcome: outcome),
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
