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
              name: "WSZYSTKO", isSelected: false, importance: 0, events: [])
        ];

        for (int idx = 1; idx <= 6; idx++) {
          List<Event> events = await getEvents.call(idx);

          categories.add(
            SportCategory(
                name: categoriesNames[idx],
                isSelected: false,
                importance: idx,
                events: events),
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
  }
}
