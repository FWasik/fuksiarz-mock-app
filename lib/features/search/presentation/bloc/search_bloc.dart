// ignore_for_file: unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';
import 'package:fuksiarz_mock_app/features/search/domain/usecases/get_searched_events.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  GetSearchedEvents getSearchedEvents;

  SearchBloc({required this.getSearchedEvents}) : super(SearchInitial()) {
    on<FetchedEventsSearchedEvent>((event, emit) async {
      try {
        emit(LoadingState());

        String pattern = event.pattern;

        List<SportCategory3Name> categories = [];
        List<EventSearched> events = await getSearchedEvents.call(pattern);

        for (EventSearched event in events) {
          String categoryName = event.category3Name;

          SportCategory3Name? existingCategory =
              categories.cast<SportCategory3Name?>().firstWhere(
                    (subsubcategory) => subsubcategory!.name == categoryName,
                    orElse: () => null,
                  );

          if (existingCategory != null) {
            existingCategory.events.add(event);
          } else {
            categories
                .add(SportCategory3Name(name: categoryName, events: [event]));
          }
        }

        categories.sort((a, b) => a.name.compareTo(b.name));

        emit(FetchedEventsSearchedState(categories: categories));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });

    on<ClearEventsSearchedEvent>(
      (event, emit) async {
        emit(SearchInitial());
      },
    );
  }
}
