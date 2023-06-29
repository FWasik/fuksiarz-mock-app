import 'package:equatable/equatable.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';

class Event extends Equatable {
  final String eventName;
  final int eventType;
  final String category1Name;
  final String category2Name;
  final String category3Name;
  final List<EventGame> eventGames;

  const Event(
      {required this.eventName,
      required this.eventType,
      required this.category1Name,
      required this.category2Name,
      required this.category3Name,
      required this.eventGames});

  @override
  List<Object?> get props => [
        eventName,
        eventType,
        category1Name,
        category2Name,
        category3Name,
        eventGames
      ];
}
