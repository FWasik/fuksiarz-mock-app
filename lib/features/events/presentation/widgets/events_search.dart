import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController searchController;

  const SearchInput({Key? key, required this.searchController})
      : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(119, 243, 243, 243),
          border: Border.all(color: Colors.grey[300]!)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: TextField(
          controller: widget.searchController,
          style: const TextStyle(backgroundColor: Colors.white, fontSize: 14),
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: "CZEGO SZUKASZ?"),
        ),
      ),
    );
  }
}
