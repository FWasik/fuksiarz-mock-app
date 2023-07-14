import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/common/category.dart';

class EventsCategoryButton extends StatelessWidget {
  final SportCategory1Name category;
  final VoidCallback onPressed;

  const EventsCategoryButton(
      {Key? key, required this.category, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor:
              category.isSelected ? Colors.blueGrey[100] : Colors.white,
        ),
        child: Row(
          children: [
            Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (category.isSelected) ...[
              const SizedBox(width: 8.0),
              Text(
                category.numOfGames.toString(),
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
