// ignore_for_file: unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/usecases/get_events.dart';
import 'package:fuksiarz_mock_app/common/category.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  GetEvents getEvents;

  EventsBloc({required this.getEvents}) : super(EventsInitial()) {
    on<FetchedEventsEvent>((event, emit) async {
      try {
        emit(LoadingState());

        List<SportCategory1Name> categories = [
          SportCategory1Name(
            name: "WSZYSTKO",
            importance: 0,
            subcategories: [],
            numOfGames: 0,
          )
        ];

        for (int idx = 1; idx <= 10; idx++) {
          List<Event>? events = await getEvents.call(idx);

          if (events.isNotEmpty) {
            List<SportCategory2Name> subcategories = [];

            for (Event event in events) {
              String nameOfSubcategory = event.category2Name;
              String nameOfSubsubcategory = event.category3Name;

              SportCategory2Name? existingSubcategory =
                  subcategories.cast<SportCategory2Name?>().firstWhere(
                        (subcategory) => subcategory!.name == nameOfSubcategory,
                        orElse: () => null,
                      );

              if (existingSubcategory != null) {
                SportCategory3Name? existingSubsubcategory = existingSubcategory
                    .subsubcategories
                    .cast<SportCategory3Name?>()
                    .firstWhere(
                      (subsubcategory) =>
                          subsubcategory!.name == nameOfSubsubcategory,
                      orElse: () => null,
                    );

                if (existingSubsubcategory != null) {
                  existingSubsubcategory.events.add(event);
                } else {
                  existingSubcategory.subsubcategories.add(SportCategory3Name(
                      name: nameOfSubsubcategory, events: [event]));
                }
              } else {
                subcategories.add(SportCategory2Name(
                    name: nameOfSubcategory,
                    subsubcategories: [
                      SportCategory3Name(
                          name: nameOfSubsubcategory, events: [event])
                    ]));
              }
            }

            categories.add(
              SportCategory1Name(
                name: events[0].category1Name,
                importance: idx,
                subcategories: subcategories,
                numOfGames: 0,
              ),
            );
          }
        }

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });

    on<CategoriesFilterEvent>((event, emit) {
      try {
        SportCategory1Name currentCategory = event.currentCategory;
        List<SportCategory1Name> categories = event.categories;

        emit(LoadingState());

        if (currentCategory.name == "WSZYSTKO") {
          bool allSelected = currentCategory.isSelected;
          List<SportCategory1Name> otherCategories = categories
              .where((category) => category.isSelected == allSelected)
              .toList();

          for (SportCategory1Name category in otherCategories) {
            category.isSelected = !allSelected;
          }
        } else {
          currentCategory.isSelected = !currentCategory.isSelected;

          int count = categories.where((element) => element.isSelected).length;

          if (count == categories.length - 1) {
            categories
                .firstWhere((element) => element.name == "WSZYSTKO")
                .isSelected = currentCategory.isSelected;
          }
        }

        categories.sort(((a, b) {
          if (a.isSelected == b.isSelected) {
            return a.importance.compareTo(b.importance);
          } else {
            return a.isSelected ? -1 : 1;
          }
        }));

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });

    on<SubcategoriesFilterEvent>((event, emit) {
      try {
        SportCategory3Name currentSubsubcategory = event.currentSubsubcategory;
        SportCategory1Name currentCategory = event.currentCategory;
        List<SportCategory1Name> categories = event.categories;

        emit(LoadingState());

        currentSubsubcategory.isSelected = !currentSubsubcategory.isSelected;

        List<String> gameNames = [];
        for (SportCategory2Name subcategory in currentCategory.subcategories) {
          gameNames.addAll(
            subcategory.subsubcategories
                .where((subsub) => subsub.isSelected)
                .expand(
                  (subsub) => subsub.events.expand(
                    (event) {
                      event as Event;
                      return event.eventGames
                          .map((eventGame) => eventGame.gameName);
                    },
                  ),
                ),
          );
        }

        gameNames = Set<String>.from(gameNames).toList();

        if (gameNames.isNotEmpty) {
          gameNames.sort();
          currentCategory.gameNames = gameNames;

          currentCategory.currentGameName = gameNames[0];
        } else {
          currentCategory.currentGameName = null;
        }

        int numOfSubsubcategorySelected = currentCategory.subcategories
            .expand((subcategory) => subcategory.subsubcategories
                .where((subsubcategory) => subsubcategory.isSelected))
            .length;

        if (numOfSubsubcategorySelected == 1) {
          currentCategory.isDropdownOpen = true;
        }

        int numOfGames = 0;

        for (Event event in currentSubsubcategory.events.cast<Event>()) {
          numOfGames += event.eventGames.length;
        }

        SportCategory1Name all =
            categories.firstWhere((category) => category.name == "WSZYSTKO");

        if (currentSubsubcategory.isSelected) {
          currentCategory.numOfGames += numOfGames;
          all.numOfGames += numOfGames;
        } else {
          currentCategory.numOfGames -= numOfGames;
          all.numOfGames -= numOfGames;
        }

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });

    on<GameNameEventFilterEvent>((event, emit) {
      try {
        String gameName = event.gameName;
        SportCategory1Name currentCategory = event.currentCategory;
        List<SportCategory1Name> categories = event.categories;

        emit(LoadingState());

        currentCategory.currentGameName = gameName;

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });

    on<DropdownEventChangeEvent>((event, emit) {
      try {
        SportCategory1Name currentCategory = event.currentCategory;
        List<SportCategory1Name> categories = event.categories;

        emit(LoadingState());

        currentCategory.isDropdownOpen = !currentCategory.isDropdownOpen;

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });

    on<ExpansionEventChangeEvent>((event, emit) {
      try {
        SportCategory3Name currentSubsubcategory = event.currentSubsubcategory;
        List<SportCategory1Name> categories = event.categories;

        emit(LoadingState());

        currentSubsubcategory.isExpanded = !currentSubsubcategory.isExpanded;

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });
  }
}
