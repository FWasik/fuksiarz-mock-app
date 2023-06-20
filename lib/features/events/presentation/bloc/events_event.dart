part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class FetchedEventsEvent extends EventsEvent {}

class CategoriesFilterEvent extends EventsEvent {
  final int index;
  final List<SportCategory> categories;

  const CategoriesFilterEvent({required this.index, required this.categories});

  @override
  List<Object> get props => [index, categories];
}

class SubcategoriesFilterEvent extends EventsEvent {
  final int indexCategory;
  final int indexSubcategory;
  final List<SportCategory> categories;

  const SubcategoriesFilterEvent(
      {required this.indexCategory,
      required this.indexSubcategory,
      required this.categories});

  @override
  List<Object> get props => [indexCategory, indexSubcategory, categories];
}

class TypeEventFilterEvent extends EventsEvent {
  final String type;
  final SportCategory currentCategory;
  final List<SportCategory> categories;

  const TypeEventFilterEvent(
      {required this.type,
      required this.currentCategory,
      required this.categories});

  @override
  List<Object> get props => [type, currentCategory, categories];
}

class DropdownEventChangeEvent extends EventsEvent {
  final bool dropdownValue;
  final SportCategory currentCategory;
  final List<SportCategory> categories;

  const DropdownEventChangeEvent(
      {required this.dropdownValue,
      required this.currentCategory,
      required this.categories});

  @override
  List<Object> get props => [dropdownValue, currentCategory, categories];
}

class ExpansionEventChangeEvent extends EventsEvent {
  final bool expansionValue;
  final SportSubcategory currentSubcategory;
  final SportCategory currentCategory;
  final List<SportCategory> categories;

  const ExpansionEventChangeEvent(
      {required this.expansionValue,
      required this.currentSubcategory,
      required this.currentCategory,
      required this.categories});

  @override
  List<Object> get props => [expansionValue, currentCategory, currentCategory];
}
