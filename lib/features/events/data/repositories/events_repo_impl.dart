import 'package:fuksiarz_mock_app/features/events/data/datasources/events_data_source.dart';
import 'package:fuksiarz_mock_app/features/events/data/models/event_dto.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/repositories/events_repo.dart';

class EventsRepoImpl extends IEvents {
  final EventsDataSource eventsDataSource;

  EventsRepoImpl({required this.eventsDataSource});

  @override
  Future<List<Event>> getAllEvents(int id) async {
    final json = await eventsDataSource.fetchAllEvents(id);

    List<Event> events = [];

    for (Map<String, dynamic> event in json["data"]) {
      events.add(EventDTO.fromJson(event));
    }

    return events;
  }
}
