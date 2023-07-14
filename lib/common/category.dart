import 'package:fuksiarz_mock_app/common/events_base.dart';

abstract class SportCategoryBase {
  String name;

  SportCategoryBase({required this.name});
}

class SportCategory1Name extends SportCategoryBase {
  bool isSelected = false;
  bool isDropdownOpen = false;
  int importance;
  List<SportCategory2Name> subcategories;
  int numOfGames;

  List<String>? gameNames;
  String? currentGameName;

  SportCategory1Name({
    required name,
    required this.importance,
    required this.subcategories,
    required this.numOfGames,
    this.gameNames,
    this.currentGameName,
  }) : super(name: name);
}

class SportCategory3Name extends SportCategoryBase {
  List<EventBase> events;

  bool isSelected = false;
  bool isExpanded = false;

  SportCategory3Name({required name, required this.events}) : super(name: name);
}

class SportCategory2Name extends SportCategoryBase {
  List<SportCategory3Name> subsubcategories;

  SportCategory2Name({required name, required this.subsubcategories})
      : super(name: name);
}
