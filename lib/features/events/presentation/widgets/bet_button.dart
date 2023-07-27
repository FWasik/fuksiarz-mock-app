import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';

class BetButton extends StatelessWidget {
  final FetchedEventsState state;
  final Outcome outcome;
  final EventGame eventGame;

  const BetButton({
    Key? key,
    required this.state,
    required this.eventGame,
    required this.outcome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(3.0),
      height: 60,
      width: width * 0.15,
      constraints: const BoxConstraints(minWidth: 65),
      child: OutlinedButton(
        onPressed: () {
          BlocProvider.of<EventsBloc>(context).add(ClickedButtonEvent(
            categories: state.categories,
            eventGame: eventGame,
            outcome: outcome,
          ));
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          backgroundColor: outcome.isClicked ? Colors.red : Colors.white,
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
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    color: outcome.isClicked ? Colors.white : Colors.black),
              ),
            ),
            Text(
              outcome.outcomeOdds.toString(),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: outcome.isClicked ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
