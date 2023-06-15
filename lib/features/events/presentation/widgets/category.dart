import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';

class SportCategory {
  String name;
  bool isSelected;
  bool isDropdownOpen = false;
  int importance;
  List<Event> events;

  SportCategory(
      {required this.name,
      required this.isSelected,
      required this.importance,
      required this.events});
}
