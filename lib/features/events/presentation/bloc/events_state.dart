part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {}

class FetchedEventsState extends EventsState {
  final List<SportCategory1Name> categories;

  const FetchedEventsState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class Loading extends EventsState {}
