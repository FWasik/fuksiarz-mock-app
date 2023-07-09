import 'package:flutter/material.dart';

class EventsHeader extends StatelessWidget {
  final Widget appBarWidget;

  const EventsHeader({Key? key, required this.appBarWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.red,
          ),
        ),
        appBarWidget
      ],
    );
  }
}
