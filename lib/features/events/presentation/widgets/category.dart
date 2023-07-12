import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';

class SportCategoryBase {
  String name;

  SportCategoryBase({required this.name});
}

class SportCategory1Name extends SportCategoryBase {
  bool isSelected = false;
  bool isDropdownOpen = false;
  int importance;
  List<SportCategory2Name> subcategories;
  List<String>? gameNames;
  String? currentGameName;

  SportCategory1Name(
      {required name,
      required this.importance,
      required this.subcategories,
      required this.gameNames,
      required this.currentGameName})
      : super(name: name);
}

class SportCategory3Name extends SportCategoryBase {
  List<Event> events;

  bool isSelected = false;
  bool isExpanded = false;

  SportCategory3Name({required name, required this.events}) : super(name: name);
}

class SportCategory2Name extends SportCategoryBase {
  List<SportCategory3Name> subsubcategories;

  SportCategory2Name({required name, required this.subsubcategories})
      : super(name: name);
}
