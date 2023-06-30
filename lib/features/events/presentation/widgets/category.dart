import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';

class SportCategory1Name {
  String name;
  bool isSelected = false;
  bool isDropdownOpen = false;
  int importance;
  List<SportCategory2Name> subcategories;
  List<String>? gameNames;
  String? currentGameName;

  SportCategory1Name(
      {required this.name,
      required this.importance,
      required this.subcategories,
      required this.gameNames,
      required this.currentGameName});
}

class SportCategory3Name {
  String name;
  List<Event> events;

  bool isSelected = false;
  bool isExpanded = false;

  SportCategory3Name({required this.name, required this.events});
}

class SportCategory2Name {
  String name;
  List<SportCategory3Name> subsubcategories;

  SportCategory2Name({required this.name, required this.subsubcategories});
}
