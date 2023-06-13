part of 'categories_filter_bloc.dart';

abstract class CategoriesFilterState extends Equatable {
  const CategoriesFilterState();

  @override
  List<Object> get props => [];
}

class CategoriesFilterReloading extends CategoriesFilterState {}

class CategoriesFilterInital extends CategoriesFilterState {
  final List<SportCategory> sports;

  const CategoriesFilterInital({required this.sports});
}
