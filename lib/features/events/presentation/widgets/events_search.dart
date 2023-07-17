import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/search/presentation/pages/events_search_page.dart';

class SearchInputNavigator extends StatelessWidget {
  const SearchInputNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EventsSearchPage(),
            ),
          );
        },
        style: const TextStyle(backgroundColor: Colors.white, fontSize: 13),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintText: "CZEGO SZUKASZ"),
      ),
    );
  }
}
