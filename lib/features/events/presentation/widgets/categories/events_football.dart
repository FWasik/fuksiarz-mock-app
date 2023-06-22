import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/bet_widget.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/custom_progress_indicator.dart';

class EventsFootball extends StatelessWidget {
  final EventGame eventGame;

  const EventsFootball({Key? key, required this.eventGame}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    List<String> team_splitted = eventGame.eventName.split(" - ");
    String first_team = team_splitted[0];
    String second_team = team_splitted[1];

    int time = 45;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: height / 6,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${eventGame.category3Name} 16.06",
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
              const Text(
                "18:00",
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
              // SizedBox(
              //   width: width / 3,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(first_team,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //           softWrap: false,
              //           style: const TextStyle(
              //               fontSize: 12, fontWeight: FontWeight.bold)),
              //       const SizedBox(height: 5),
              //       Text(second_team,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //           softWrap: false,
              //           style: const TextStyle(
              //               fontSize: 12, fontWeight: FontWeight.bold))
              //     ],
              //   ),
              // ),
              Text(
                first_team + "\n" + second_team,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 4),
              if (eventGame.outcomes.length > 3) ...[
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
              ] else
                for (Outcome outcome in eventGame.outcomes) ...[
                  const Spacer(flex: 1),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 6.0),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side:
                              const BorderSide(color: Colors.grey, width: 0.8)),
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
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
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
