import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/usecases/get_events.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/category.dart';

part 'events_event.dart';
part 'events_state.dart';

List<String> categoriesNames = [
  "WSZYSTKO",
  "PIŁKA NOŻNA",
  "KOSZYKÓWKA",
  "BASEBALL",
  "HOKEJ NA LODZIE",
  "TENIS",
  "PIŁKA RĘCZNA"
];

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  GetEvents getEvents;

  EventsBloc({required this.getEvents}) : super(EventsInitial()) {
    on<FetchedEventsEvent>((event, emit) async {
      try {
        List<SportCategory1Name> categories = [
          SportCategory1Name(
              name: "WSZYSTKO",
              importance: 0,
              subcategories: [],
              gameNames: [],
              currentGameName: "")
        ];

        for (int idx = 1; idx <= 6; idx++) {
          List<Event> events = await getEvents.call(idx);

          List<SportCategory2Name> subcategories = [];

          for (Event event in events) {
            String nameOfSubcategory = event.category2Name;
            String nameOfSubsubcategory =
                "${event.category2Name}  >  ${event.category3Name}";

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
                name: categoriesNames[idx],
                importance: idx,
                subcategories: subcategories,
                gameNames: null,
                currentGameName: null),
          );
        }

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        print(e.toString());
      }
    });

    on<CategoriesFilterEvent>((event, emit) {
      int index = event.index;
      List<SportCategory1Name> categories = event.categories;

      emit(Loading());

      if (categories[index].name == "WSZYSTKO") {
        bool allSelected = categories[index].isSelected;

        for (var category in categories) {
          category.isSelected = !allSelected;
        }
      } else {
        categories[index].isSelected = !categories[index].isSelected;

        int count = categories.where((element) => element.isSelected).length;

        if (count == categories.length - 1) {
          categories
              .firstWhere((element) => element.name == "WSZYSTKO")
              .isSelected = categories[index].isSelected;
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
    });

    on<SubcategoriesFilterEvent>((event, emit) {
      SportCategory3Name currentSubsubcategory = event.currentSubsubcategory;
      SportCategory1Name currentCategory = event.currentCategory;
      List<SportCategory1Name> categories = event.categories;

      emit(Loading());

      currentSubsubcategory.isSelected = !currentSubsubcategory.isSelected;

      List<String> gameNames = [];
      for (SportCategory2Name subcategory in currentCategory.subcategories) {
        gameNames.addAll(
          subcategory.subsubcategories
              .where((subsub) => subsub.isSelected)
              .expand(
                (subsub) => subsub.events.expand(
                  (event) =>
                      event.eventGames.map((eventGame) => eventGame.gameName),
                ),
              ),
        );
      }

      gameNames = Set<String>.from(gameNames).toList();

      currentCategory.gameNames = gameNames;
      currentCategory.currentGameName = gameNames[0];

      emit(FetchedEventsState(categories: categories));
    });

    on<GameNameEventFilterEvent>((event, emit) {
      String gameName = event.gameName;
      SportCategory1Name currentCategory = event.currentCategory;
      List<SportCategory1Name> categories = event.categories;

      emit(Loading());

      currentCategory.currentGameName = gameName;

      emit(FetchedEventsState(categories: categories));
    });

    on<DropdownEventChangeEvent>((event, emit) {
      SportCategory1Name currentCategory = event.currentCategory;
      List<SportCategory1Name> categories = event.categories;

      emit(Loading());

      currentCategory.isDropdownOpen = !currentCategory.isDropdownOpen;

      emit(FetchedEventsState(categories: categories));
    });

    on<ExpansionEventChangeEvent>((event, emit) {
      SportCategory3Name currentSubsubcategory = event.currentSubsubcategory;
      List<SportCategory1Name> categories = event.categories;

      emit(Loading());

      currentSubsubcategory.isExpanded = !currentSubsubcategory.isExpanded;

      emit(FetchedEventsState(categories: categories));
    });
  }
}
