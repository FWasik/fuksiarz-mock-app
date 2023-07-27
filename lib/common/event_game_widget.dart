import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/common/events_base.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/bet_button.dart';
import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';

class EventGameWidget extends StatelessWidget {
  final FetchedEventsState? state;
  final SportCategory3Name subsubcategory;
  final EventBase event;
  final EventGame? eventGame;

  const EventGameWidget({
    Key? key,
    required this.subsubcategory,
    required this.event,
    this.eventGame,
    this.state,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isLiveAndSearched =
        event is EventSearched && (event as EventSearched).area == "LIVE_EVENT";

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildFirstRow(),
                  buildSecondRow(isLiveAndSearched, width),
                  buildThirdRow(isLiveAndSearched, width),
                  if (isLiveAndSearched) ...[buildAdditionalInfo()]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildFirstRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Text(
              "${subsubcategory.name}   ${event.eventDate}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (event is EventSearched) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: buildIconContainer(
                      "TV",
                      Colors.blueGrey[300]!,
                      const Icon(
                        Icons.tv,
                        color: Colors.white,
                        size: 14.0,
                      ),
                      45,
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: buildIconContainer(
                    "HOT",
                    Colors.redAccent[700]!,
                    const Icon(
                      Icons.local_fire_department_outlined,
                      color: Colors.white,
                      size: 14.0,
                    ),
                    50,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSecondRow(bool isLiveAndSearched, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          isLiveAndSearched
              ? buildIconContainer(
                  "60'",
                  Colors.green,
                  const Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 7,
                  ),
                  40)
              : Text(
                  event.eventTime,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: buildIndicator(isLiveAndSearched, width),
            ),
          ),
          Text(
            "+ 111",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent[700]),
          )
        ],
      ),
    );
  }

  Widget buildThirdRow(bool isLiveAndSearched, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildGameName(width),
          if (isLiveAndSearched) ...[
            const Spacer(flex: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "0",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "0",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "0",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "0",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "0",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
          buildOdds(),
        ],
      ),
    );
  }

  Widget buildGameName(double width) {
    List<String> teamSplitted = event.eventName.split(" - ");

    if ((eventGame != null && eventGame!.gameLayout == 9) ||
        teamSplitted.length == 1) {
      return SizedBox(
        width: width * 0.45,
        child: Text(
          event.eventName,
          maxLines: 4,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return SizedBox(
        width: width * 0.40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              teamSplitted[0],
              maxLines: 2,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6.0),
            Text(
              teamSplitted[1],
              maxLines: 2,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }

  Widget buildOdds() {
    if (event is EventSearched ||
        eventGame!.gameLayout == 20 ||
        eventGame!.gameLayout == 9) {
      return GestureDetector(
        child: Container(
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
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: eventGame!.outcomes
              .map(
                (outcome) => BetButton(
                    state: state!, eventGame: eventGame!, outcome: outcome),
              )
              .toList(),
        ),
      );
    }
  }

  Widget buildIconContainer(
      String text, Color backgroudnColor, Icon icon, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: backgroudnColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          icon,
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ),
    );
  }

  Widget buildAdditionalInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  event.eventTime,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 10),
                ),
              ),
            ),
            const Text("Coś o czymś...", style: TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isLiveAndSearched, double width) {
    double currentValue = 60;

    if (isLiveAndSearched) {
      return Row(
        children: [
          Flexible(
            child: LinearProgressIndicator(
              minHeight: 3,
              value: currentValue / 45,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: LinearProgressIndicator(
              minHeight: 3,
              value: (currentValue - 45) / 45,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ],
      );
    } else {
      return LinearProgressIndicator(
        minHeight: 2,
        value: 0,
        backgroundColor: Colors.grey[300],
      );
    }
  }
}
