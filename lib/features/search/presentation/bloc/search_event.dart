part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchedEventsSearchedEvent extends SearchEvent {
  final String pattern;

  const FetchedEventsSearchedEvent({required this.pattern});

  @override
  List<Object> get props => [pattern];
}

class ClearEventsSearchedEvent extends SearchEvent {}
