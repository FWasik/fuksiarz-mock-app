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

          List<String> typesOfEventGames = [];
          List<SportSubcategory> subcategories = [];

          for (Event event in events) {
            typesOfEventGames.addAll(event.eventGames
                .map((eventGame) => eventGame.gameName)
                .toList());

            // String nameOfSubcategory =
            //     "${event.category2Name} > ${event.category3Name}";

            String nameOfSubcategory = event.category2Name;
            SportSubcategory? existingSubcategory =
                subcategories.cast<SportSubcategory?>().firstWhere(
                      (subcategory) => subcategory!.name == nameOfSubcategory,
                      orElse: () => null,
                    );

            if (existingSubcategory != null) {
              existingSubcategory.eventGames.addAll(event.eventGames);
            } else {
              subcategories.add(SportSubcategory(
                  name: nameOfSubcategory, eventGames: event.eventGames));
            }
          }

          typesOfEventGames = Set<String>.from(typesOfEventGames).toList();

          categories.add(
            SportCategory(
                name: categoriesNames[idx],
                importance: idx,
                subcategories: subcategories,
                typesOfEventGames: typesOfEventGames,
                currentType: typesOfEventGames[0]),
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
      int indexSubcategory = event.indexSubcategory;
      int indexCategory = event.indexCategory;

      List<SportCategory> categories = event.categories;

      emit(Loading());

      bool isSelected =
          categories[indexCategory].subcategories[indexSubcategory].isSelected;

      categories[indexCategory].subcategories[indexSubcategory].isSelected =
          !isSelected;

      emit(FetchedEventsState(categories: categories));
    });

    on<TypeEventFilterEvent>((event, emit) {
      String type = event.type;
      SportCategory currentCategory = event.currentCategory;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      int index = categories.indexOf(currentCategory);

      categories[index].currentType = type;

      emit(FetchedEventsState(categories: categories));
    });

    on<DropdownEventChangeEvent>((event, emit) {
      bool dropdownValue = event.dropdownValue;
      SportCategory currentCategory = event.currentCategory;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      int index = categories.indexOf(currentCategory);

      categories[index].isDropdownOpen = dropdownValue;

      emit(FetchedEventsState(categories: categories));
    });

    on<ExpansionEventChangeEvent>((event, emit) {
      bool expansionValue = event.expansionValue;
      SportSubcategory currentSubcategory = event.currentSubcategory;
      SportCategory currentCategory = event.currentCategory;
      List<SportCategory> categories = event.categories;

      emit(Loading());

      int indexSub = currentCategory.subcategories.indexOf(currentSubcategory);

      currentSubcategory.isExpanded = expansionValue;
      currentCategory.subcategories[indexSub].isExpanded = expansionValue;

      int index = event.categories.indexOf(currentCategory);

      categories[index] = currentCategory;

      emit(FetchedEventsState(categories: categories));
    });
  }
}
