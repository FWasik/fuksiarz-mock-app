import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';

abstract class IEvents {
  Future<List<Event>> getEventsById(int id);
}
