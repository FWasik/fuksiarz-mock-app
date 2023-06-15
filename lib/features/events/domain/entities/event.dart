import 'package:equatable/equatable.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';

class Event extends Equatable {
  final String eventName;
  final String category1Name;
  final String category2Name;
  final List<EventGame> eventGames;

  const Event(
      {required this.eventName,
      required this.category1Name,
      required this.category2Name,
      required this.eventGames});

  @override
  List<Object?> get props =>
      [eventName, category1Name, category2Name, eventGames];
}
