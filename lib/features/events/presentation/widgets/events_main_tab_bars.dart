import 'package:flutter/material.dart';

class EventsMainTabBars extends StatefulWidget {
  Function(int) changeIndexCallback;

  EventsMainTabBars({Key? key, required this.changeIndexCallback})
      : super(key: key);

  @override
  State<EventsMainTabBars> createState() => _EventsMainTabBarsState();
}

class _EventsMainTabBarsState extends State<EventsMainTabBars> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 245, 245, 245),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        indicatorColor: Colors.white,
        labelColor: Colors.black,
        indicator: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4.0,
              spreadRadius: 0.0,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        unselectedLabelColor: Colors.black,
        onTap: (index) {
          widget.changeIndexCallback(index);
        },
        tabs: const [
          Tab(
            child: Text(
              "Oferta",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Tab(
            child: Text(
              "Moje",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Tab(
            child: Text(
              "Live",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Tab(
            child: Text(
              "Hot",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Tab(
            child: Text(
              "Cashback",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Tab(
            icon: Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
