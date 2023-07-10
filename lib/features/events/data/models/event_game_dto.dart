import 'package:fuksiarz_mock_app/features/events/data/models/outcome_dto.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';

class EventGameDTO extends EventGame {
  const EventGameDTO({
    required gameName,
    required outcomes,
  }) : super(gameName: gameName, outcomes: outcomes);

  factory EventGameDTO.fromJson(Map<String, dynamic> json) {
    List<Outcome> outcomes = [];

    for (Map<String, dynamic> outcome in json["outcomes"]) {
      outcomes.add(OutcomeDTO.fromJson(outcome));
    }

    // if (outcomes[0].outcomeName.contains("/") &&
    //     outcomes[1].outcomeName.contains("/")) {
    //   outcomes[0].outcomeName = "1";
    //   outcomes[0].outcomeName = "2";
    // }

    return EventGameDTO(gameName: json["gameName"], outcomes: outcomes);
  }
}
