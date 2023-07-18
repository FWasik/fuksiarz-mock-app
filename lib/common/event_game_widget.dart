import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/common/events_base.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/bet_button.dart';
import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';

class EventGameWidget extends StatelessWidget {
  final SportCategory3Name subsubcategory;
  final EventBase event;
  final EventGame? eventGame;

  const EventGameWidget(
      {Key? key,
      required this.subsubcategory,
      required this.event,
      this.eventGame})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 140),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10.0)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: width * 0.6),
                child: Text(
                  subsubcategory.name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(flex: 1),
              Text(
                event.eventDate,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 30),
              Container(
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.local_fire_department_outlined,
                          color: Colors.white,
                          size: 14.0,
                        ),
                        Text(
                          "HOT",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ]),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                event.eventTime,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: LinearProgressIndicator(
                    minHeight: 0.8,
                    value: 0,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
              const Text(
                "111",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildGameName(width),
              buildOdds(width),
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildGameName(double width) {
    List<String> teamSplitted = event.eventName.split(" - ");

    if ((eventGame != null && eventGame!.gameLayout == 9) ||
        teamSplitted.length == 1) {
      return SizedBox(
        width: width * 0.4,
        child: Text(
          event.eventName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return SizedBox(
        width: width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              teamSplitted[0],
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              teamSplitted[1],
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }

  Widget buildOdds(double width) {
    if (event is EventSearched ||
        eventGame!.gameLayout == 20 ||
        eventGame!.gameLayout == 9) {
      return GestureDetector(
        child: Container(
          width: width * 0.4,
          padding: const EdgeInsets.all(13.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: const Center(
            child: Text(
              "DO WYDARZENIA",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      return Flexible(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: eventGame!.outcomes
                .map(
                  (outcome) => BetButton(outcome: outcome),
                )
                .toList(),
          ),
        ),
      );
    }
  }
}
