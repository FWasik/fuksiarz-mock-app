import 'package:fuksiarz_mock_app/features/events/presentation/widgets/category.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_filter_event.dart';
part 'categories_filter_state.dart';

List<SportCategory> sports = [
  SportCategory(name: "PIŁKA NOŻNA", isSelected: true, importance: 2),
  SportCategory(name: "KOSZYKÓWKA", isSelected: true, importance: 3),
  SportCategory(name: "TENIS", isSelected: true, importance: 4),
  SportCategory(name: "WSZYSTKO", isSelected: false, importance: 1),
  SportCategory(name: "SIATKÓWKA", isSelected: false, importance: 5),
  SportCategory(name: "BASEBALL", isSelected: false, importance: 6),
  SportCategory(name: "COUNTER STRIKE", isSelected: false, importance: 7),
  SportCategory(name: "BOKS", isSelected: false, importance: 8),
  SportCategory(name: "HOKEJ NA LODZIE", isSelected: false, importance: 9),
  SportCategory(name: "DARTS", isSelected: false, importance: 10),
  SportCategory(name: "F1", isSelected: false, importance: 11)
];

class CategoriesFilterBloc
    extends Bloc<CategoriesFilterEvent, CategoriesFilterState> {
  CategoriesFilterBloc() : super(CategoriesFilterInital(sports: sports)) {
    on<CategriesFilterRequested>((event, emit) {
      int index = event.index;
      List<SportCategory> currentSports = event.currentSports;

      emit(CategoriesFilterReloading());

      if (currentSports[index].name == "WSZYSTKO") {
        bool allSelected = currentSports[index].isSelected;

        for (var sport in currentSports) {
          sport.isSelected = !allSelected;
        }
      } else {
        currentSports[index].isSelected = !currentSports[index].isSelected;

        int count = currentSports
            .where((element) =>
                element.isSelected == currentSports[index].isSelected)
            .length;

        if (count == 1 || count == currentSports.length - 1) {
          currentSports
              .firstWhere((element) => element.name == "WSZYSTKO")
              .isSelected = currentSports[index].isSelected;
        }
      }

      currentSports.sort(((a, b) {
        if (a.isSelected == b.isSelected) {
          return a.importance.compareTo(b.importance);
        } else {
          return a.isSelected ? -1 : 1;
        }
      }));

      emit(CategoriesFilterInital(sports: currentSports));
    });
  }
}
