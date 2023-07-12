import 'package:fuksiarz_mock_app/features/search/data/datasources/search_data_source.dart';
import 'package:fuksiarz_mock_app/features/search/data/models/event_searched_dto.dart';
import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';
import 'package:fuksiarz_mock_app/features/search/domain/repositories/search_repo.dart';

class SearchRepoImpl extends ISearch {
  final SearchDataSource searchDataSource;

  SearchRepoImpl({required this.searchDataSource});

  @override
  Future<List<EventSearched>> getSearchEventsByPattern(String pattern) async {
    final json = await searchDataSource.getSearchEventsByPattern(pattern);

    List<EventSearched> searchedEvents = [];

    for (Map<String, dynamic> event in json["data"]) {
      searchedEvents.add(EventSearchedDTO.fromJson(event));
    }

    return searchedEvents;
  }
}
