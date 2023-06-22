import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';

class SportCategory {
  String name;
  bool isSelected = false;
  bool isDropdownOpen = false;
  int importance;
  List<SportSubcategory> subcategories;
  List<String>? typesOfEventGames;
  String? currentType;

  SportCategory(
      {required this.name,
      required this.importance,
      required this.subcategories,
      required this.typesOfEventGames,
      required this.currentType});
}

class SportSubsubcategory {
  String name;
  List<EventGame> eventGames;

  bool isSelected = false;
  bool isExpanded = false;

  SportSubsubcategory({required this.name, required this.eventGames});
}

class SportSubcategory {
  String name;
  List<SportSubsubcategory> subsubcategories;

  SportSubcategory({required this.name, required this.subsubcategories});
}
