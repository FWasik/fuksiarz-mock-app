import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';

abstract class ISearch {
  Future<List<EventSearched>> getSearchEventsByPattern(String pattern);
}
