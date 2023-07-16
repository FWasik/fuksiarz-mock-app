import 'package:equatable/equatable.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';

class EventGame extends Equatable {
  final String gameName;
  final List<Outcome> outcomes;
  final int gameLayout;

  const EventGame({
    required this.gameName,
    required this.outcomes,
    required this.gameLayout,
  });

  @override
  List<Object?> get props => [gameName, outcomes, gameLayout];
}
