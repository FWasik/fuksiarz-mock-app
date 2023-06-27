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
        List<SportCategory> categories = [
          SportCategory(
              name: "WSZYSTKO",
              importance: 0,
              subcategories: [],
              typesOfEventGames: [],
              currentType: "")
        ];

        for (int idx = 1; idx <= 6; idx++) {
          List<Event> events = await getEvents.call(idx);

          List<SportSubcategory> subcategories = [];
          List<SportSubsubcategory> subsubcategories = [];

          for (Event event in events) {
            String nameOfSubcategory = event.category2Name;
            String nameOfSubsubcategory =
                "${event.category2Name} > ${event.category3Name}";

            SportSubcategory? existingSubcategory =
                subcategories.cast<SportSubcategory?>().firstWhere(
                      (subcategory) => subcategory!.name == nameOfSubcategory,
                      orElse: () => null,
                    );

            if (existingSubcategory != null) {
              SportSubsubcategory? existingSubsubcategory = existingSubcategory
                  .subsubcategories
                  .cast<SportSubsubcategory?>()
                  .firstWhere(
                    (subsubcategory) =>
                        subsubcategory!.name == nameOfSubsubcategory,
                    orElse: () => null,
                  );

              if (existingSubsubcategory != null) {
                existingSubsubcategory.eventGames.addAll(event.eventGames);
              } else {
                existingSubcategory.subsubcategories.add(SportSubsubcategory(
                    name: nameOfSubsubcategory, eventGames: event.eventGames));
              }
            } else {
              subcategories.add(SportSubcategory(
                  name: nameOfSubcategory,
                  subsubcategories: [
                    SportSubsubcategory(
                        name: nameOfSubsubcategory,
                        eventGames: event.eventGames)
                  ]));
            }
          }

          categories.add(
            SportCategory(
                name: categoriesNames[idx],
                importance: idx,
                subcategories: subcategories,
                typesOfEventGames: null,
                currentType: null),
          );
        }

        emit(FetchedEventsState(categories: categories));
      } on Exception catch (e) {
        print(e.toString());
      }
    });

    on<CategoriesFilterEvent>((event, emit) {
      int index = event.index;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      if (categories[index].name == "WSZYSTKO") {
        bool allSelected = categories[index].isSelected;

        for (var category in categories) {
          category.isSelected = !allSelected;
        }
      } else {
        categories[index].isSelected = !categories[index].isSelected;

        int count =
            categories.where((element) => element.isSelected == true).length;

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
      SportSubsubcategory currentSubsubcategory = event.currentSubsubcategory;
      SportCategory currentCategory = event.currentCategory;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      currentSubsubcategory.isSelected = !currentSubsubcategory.isSelected;

      List<String> typesOfEventGames = [];
      for (SportSubcategory subcategory in currentCategory.subcategories) {
        typesOfEventGames.addAll(
          subcategory.subsubcategories
              .where((subsub) => subsub.isSelected)
              .expand(
                (subsub) =>
                    subsub.eventGames.map((eventGame) => eventGame.gameName),
              ),
        );
      }

      typesOfEventGames = Set<String>.from(typesOfEventGames).toList();

      currentCategory.typesOfEventGames = typesOfEventGames;
      currentCategory.currentType = typesOfEventGames[0];

      emit(FetchedEventsState(categories: categories));
    });

    on<TypeEventFilterEvent>((event, emit) {
      String type = event.type;
      SportCategory currentCategory = event.currentCategory;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      currentCategory.currentType = type;

      emit(FetchedEventsState(categories: categories));
    });

    on<DropdownEventChangeEvent>((event, emit) {
      SportCategory currentCategory = event.currentCategory;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      currentCategory.isDropdownOpen = !currentCategory.isDropdownOpen;

      emit(FetchedEventsState(categories: categories));
    });

    on<ExpansionEventChangeEvent>((event, emit) {
      SportSubsubcategory currentSubsubcategory = event.currentSubsubcategory;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      currentSubsubcategory.isExpanded = !currentSubsubcategory.isExpanded;

      emit(FetchedEventsState(categories: categories));
    });
  }
}
