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
  final SportSubsubcategory currentSubsubcategory;
  final SportCategory currentCategory;

  final List<SportCategory> categories;

  const SubcategoriesFilterEvent(
      {required this.currentSubsubcategory,
      required this.currentCategory,
      required this.categories});

  @override
  List<Object> get props =>
      [currentSubsubcategory, currentCategory, categories];
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
  final SportCategory currentCategory;
  final List<SportCategory> categories;

  const DropdownEventChangeEvent(
      {required this.currentCategory, required this.categories});

  @override
  List<Object> get props => [currentCategory, categories];
}

class ExpansionEventChangeEvent extends EventsEvent {
  final SportSubsubcategory currentSubsubcategory;

  final List<SportCategory> categories;

  const ExpansionEventChangeEvent(
      {required this.currentSubsubcategory, required this.categories});

  @override
  List<Object> get props => [currentSubsubcategory, categories];
}
