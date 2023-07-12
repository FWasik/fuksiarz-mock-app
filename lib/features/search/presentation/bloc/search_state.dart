part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class FetchedEventsSearchedState extends SearchState {
  final List<SportCategory3Name> categories;

  const FetchedEventsSearchedState({required this.categories});
}

class Loading extends SearchState {}
