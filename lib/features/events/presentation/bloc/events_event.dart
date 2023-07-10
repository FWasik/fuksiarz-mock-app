part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class FetchedEventsEvent extends EventsEvent {}

class CategoriesFilterEvent extends EventsEvent {
  final SportCategory1Name currentCategory;
  final List<SportCategory1Name> categories;

  const CategoriesFilterEvent(
      {required this.currentCategory, required this.categories});

  @override
  List<Object> get props => [currentCategory, categories];
}

class SubcategoriesFilterEvent extends EventsEvent {
  final SportCategory3Name currentSubsubcategory;
  final SportCategory1Name currentCategory;

  final List<SportCategory1Name> categories;

  const SubcategoriesFilterEvent(
      {required this.currentSubsubcategory,
      required this.currentCategory,
      required this.categories});

  @override
  List<Object> get props =>
      [currentSubsubcategory, currentCategory, categories];
}

class GameNameEventFilterEvent extends EventsEvent {
  final String gameName;
  final SportCategory1Name currentCategory;
  final List<SportCategory1Name> categories;

  const GameNameEventFilterEvent(
      {required this.gameName,
      required this.currentCategory,
      required this.categories});

  @override
  List<Object> get props => [gameName, currentCategory, categories];
}

class DropdownEventChangeEvent extends EventsEvent {
  final SportCategory1Name currentCategory;
  final List<SportCategory1Name> categories;

  const DropdownEventChangeEvent(
      {required this.currentCategory, required this.categories});

  @override
  List<Object> get props => [currentCategory, categories];
}

class ExpansionEventChangeEvent extends EventsEvent {
  final SportCategory3Name currentSubsubcategory;

  final List<SportCategory1Name> categories;

  const ExpansionEventChangeEvent(
      {required this.currentSubsubcategory, required this.categories});

  @override
  List<Object> get props => [currentSubsubcategory, categories];
}
