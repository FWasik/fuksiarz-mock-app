import 'package:equatable/equatable.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';

class EventGame extends Equatable {
  final String gameName;
  final List<Outcome> outcomes;
  final String eventName;
  final String category3Name;

  const EventGame(
      {required this.gameName,
      required this.outcomes,
      required this.eventName,
      required this.category3Name});

  @override
  List<Object?> get props => [gameName, outcomes, eventName, category3Name];
}
