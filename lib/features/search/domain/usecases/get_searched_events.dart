import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';
import 'package:fuksiarz_mock_app/features/search/domain/repositories/search_repo.dart';

class GetSearchedEvents {
  final ISearch repository;

  GetSearchedEvents({required this.repository});

  Future<List<EventSearched>> call(String pattern) async {
    return await repository.getSearchEventsByPattern(pattern);
  }
}
