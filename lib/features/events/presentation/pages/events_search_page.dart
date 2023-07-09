import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_header.dart';

class EventsSearchPage extends StatefulWidget {
  const EventsSearchPage({super.key});

  @override
  State<EventsSearchPage> createState() => _EventsSearchPageState();
}

class _EventsSearchPageState extends State<EventsSearchPage> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace:
              EventsHeader(appBarWidget: appBarWidget(context, width)),
        ),
        body: Container(
          color: Colors.red,
          height: 200,
          width: 200,
        ));
  }
}

Widget appBarWidget(BuildContext context, double width) {
  return Positioned(
    top: 50,
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      width: width,
      padding: EdgeInsets.only(top: 35, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100]!,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
        ),
      ),
      child: TextField(
        style: const TextStyle(
          backgroundColor: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!)),
            border: OutlineInputBorder(),
            prefixIcon: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            hintText: "CZEGO SZUKASZ?"),
      ),
    ),
  );
}
