import 'package:flutter/material.dart';

class EventsCustomWidgetSwitcher extends StatefulWidget {
  final Function(int) changeIndexCallback;

  const EventsCustomWidgetSwitcher(
      {Key? key, required this.changeIndexCallback})
      : super(key: key);

  @override
  State<EventsCustomWidgetSwitcher> createState() =>
      _EventsCustomWidgetSwitcherState();
}

class _EventsCustomWidgetSwitcherState
    extends State<EventsCustomWidgetSwitcher> {
  List<bool> isSelectedValues = [true, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(children: [
      SizedBox(
        height: 50.0,
        width: width - 60.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildTab(index: 0, text: "OFERTA"),
            buildTab(index: 1, text: "MOJE"),
            buildTab(index: 2, text: "LIVE"),
            buildTab(index: 3, text: "HOT"),
            buildTab(index: 4, text: "CASHBACK"),
            buildTab(index: 5, text: "CASHBACK"),
          ],
        ),
      ),
      Material(
        elevation: 5,
        child: Container(
          height: 50.0,
          width: 60.0,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month),
          ),
        ),
      ),
    ]);
  }

  Widget buildTab({required int index, required String text}) {
    bool isSelected = isSelectedValues[index];

    return GestureDetector(
      onTap: () {
        widget.changeIndexCallback(index);

        isSelectedValues = isSelectedValues.map((e) => false).toList();
        isSelectedValues[index] = true;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        constraints: const BoxConstraints(minWidth: 50.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[50] : Colors.white10,
          border: Border(
            left: BorderSide(
              color: isSelected ? Colors.grey[300]! : Colors.transparent,
            ),
            right: BorderSide(
              color: isSelected ? Colors.grey[300]! : Colors.transparent,
            ),
            bottom: BorderSide(
              color: isSelected ? Colors.transparent : Colors.grey[300]!,
            ),
          ),
        ),
        child: text != "LIVE"
            ? Center(
                child: Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : Row(
                children: [
                  Text(
                    text,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
