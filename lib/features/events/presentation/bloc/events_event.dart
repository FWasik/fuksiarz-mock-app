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
  List<Object> get props => [index];
}
