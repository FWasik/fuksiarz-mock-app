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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(119, 243, 243, 243),
          border: Border.all(color: Colors.grey, width: 0.2)),
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: height / 50, horizontal: width / 30),
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
