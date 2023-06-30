import 'package:fuksiarz_mock_app/features/events/data/models/event_game_dto.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:intl/intl.dart';

class EventDTO extends Event {
  const EventDTO(
      {required eventName,
      required eventType,
      required category1Name,
      required category2Name,
      required category3Name,
      required eventGames,
      required eventTime,
      required eventDate})
      : super(
            eventName: eventName,
            eventType: eventType,
            category1Name: category1Name,
            category2Name: category2Name,
            category3Name: category3Name,
            eventGames: eventGames,
            eventTime: eventTime,
            eventDate: eventDate);

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    List<EventGame> eventGames = [];

    for (Map<String, dynamic> game in json["eventGames"]) {
      eventGames.add(EventGameDTO.fromJson(
          game, json["eventName"], json["category3Name"]));
    }

    DateTime dt =
        DateTime.fromMillisecondsSinceEpoch(json["eventStart"]).toLocal();

    return EventDTO(
      eventName: json["eventName"],
      eventType: json["eventType"],
      category1Name: json["category1Name"],
      category2Name: json["category2Name"],
      category3Name: json["category3Name"],
      eventGames: eventGames,
      eventTime: DateFormat('HH:mm').format(dt),
      eventDate: DateFormat('dd.MM').format(dt),
    );
  }
}
