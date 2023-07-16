import 'package:fuksiarz_mock_app/features/events/data/models/event_game_dto.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:intl/intl.dart';

class EventDTO extends Event {
  const EventDTO({
    required eventName,
    required category2Name,
    required category3Name,
    required eventGames,
    required eventTime,
    required eventDate,
  }) : super(
            eventName: eventName,
            category2Name: category2Name,
            category3Name: category3Name,
            eventGames: eventGames,
            eventTime: eventTime,
            eventDate: eventDate);

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    List<EventGame> eventGames = [];

    for (Map<String, dynamic> game in json["eventGames"]) {
      eventGames.add(EventGameDTO.fromJson(game));
    }

    DateTime dt =
        DateTime.fromMillisecondsSinceEpoch(json["eventStart"]).toLocal();

    return EventDTO(
      eventName: json["eventName"],
      category2Name: json["category2Name"],
      category3Name: json["category3Name"],
      eventGames: eventGames,
      eventTime: DateFormat('HH:mm').format(dt),
      eventDate: DateFormat('dd.MM').format(dt),
    );
  }
}
