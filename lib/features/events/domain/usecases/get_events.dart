import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/repositories/events_repo.dart';

class GetEvents {
  final IEvents repository;

  GetEvents({required this.repository});

  Future<List<Event>> call(int id) async {
    return await repository.getEventsById(id);
  }
}
