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
        color: Colors.white,
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        indicatorColor: Colors.white,
        labelColor: Colors.black,
        indicator: BoxDecoration(
            color: Color.fromARGB(26, 158, 158, 158),
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
              left: BorderSide(color: Colors.grey[300]!),
              right: BorderSide(color: Colors.grey[300]!),
            )
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.2),
            //     blurRadius: 4.0,
            //     spreadRadius: 0.0,
            //     offset: const Offset(0, -4),
            //   ),
            // ],
            ),
        unselectedLabelColor: Colors.black,
        onTap: (index) {
          widget.changeIndexCallback(index);
        },
        tabs: [
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
            child: Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
