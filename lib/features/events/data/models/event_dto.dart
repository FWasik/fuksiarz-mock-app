import 'package:fuksiarz_mock_app/features/events/data/models/event_game_dto.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';

class EventDTO extends Event {
  const EventDTO(
      {required eventName,
      required category1Name,
      required category2Name,
      required category3Name,
      required eventGames})
      : super(
            eventName: eventName,
            category1Name: category1Name,
            category2Name: category2Name,
            category3Name: category3Name,
            eventGames: eventGames);

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    List<EventGame> eventGames = [];

    for (Map<String, dynamic> game in json["eventGames"]) {
      eventGames.add(EventGameDTO.fromJson(
          game, json["eventName"], json["category3Name"]));
    }

    return EventDTO(
        eventName: json["eventName"],
        category1Name: json["category1Name"],
        category2Name: json["category2Name"],
        category3Name: json["category3Name"],
        eventGames: eventGames);
  }
}
