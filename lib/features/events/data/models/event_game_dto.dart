import 'package:fuksiarz_mock_app/features/events/data/models/outcome_dto.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';

class EventGameDTO extends EventGame {
  const EventGameDTO({
    required gameName,
    required outcomes,
    required gameLayout,
  }) : super(gameName: gameName, outcomes: outcomes, gameLayout: gameLayout);

  factory EventGameDTO.fromJson(Map<String, dynamic> json) {
    List<Outcome> outcomes = [];

    for (Map<String, dynamic> outcome in json["outcomes"]) {
      outcomes.add(OutcomeDTO.fromJson(outcome));
    }

    return EventGameDTO(
      gameName: json["gameName"],
      outcomes: outcomes,
      gameLayout: json["gameLayout"],
    );
  }
}
