part of 'categories_filter_bloc.dart';

abstract class CategoriesFilterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategriesFilterRequested extends CategoriesFilterEvent {
  final int index;
  final List<SportCategory> currentSports;

  CategriesFilterRequested({required this.index, required this.currentSports});
}
