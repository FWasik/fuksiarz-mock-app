class SportCategory {
  String name;
  bool isSelected;
  bool isDropdownOpen = false;
  int importance;

  SportCategory(
      {required this.name, required this.isSelected, required this.importance});
}
