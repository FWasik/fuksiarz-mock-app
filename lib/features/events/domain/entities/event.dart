import 'package:fuksiarz_mock_app/common/events_base.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';

class Event extends EventBase {
  final String category1Name;
  final String category2Name;
  final List<EventGame> eventGames;

  const Event({
    required eventName,
    required eventTime,
    required eventDate,
    required category3Name,
    required this.category1Name,
    required this.category2Name,
    required this.eventGames,
  }) : super(
          eventName: eventName,
          eventTime: eventTime,
          eventDate: eventDate,
          category3Name: category3Name,
        );

  @override
  List<Object?> get props => [
        eventName,
        eventGames,
        eventTime,
        eventDate,
        category1Name,
        category2Name,
        category3Name
      ];
}
