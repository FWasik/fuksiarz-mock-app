import 'package:flutter/material.dart';

class EventsMainTabBars extends StatelessWidget {
  const EventsMainTabBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
              offset: Offset(0, -4), // Offset to move the shadow upwards
            ),
          ],
        ),
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: Text(
              "Oferta",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Tab(
            child: Text(
              "Moje",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Tab(
            child: Text(
              "Live",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Tab(
            child: Text(
              "Hot",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Tab(
            child: Text(
              "Cashback",
              style: TextStyle(fontSize: 18),
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
