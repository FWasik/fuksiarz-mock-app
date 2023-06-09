import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/pages/events_page.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_button.dart';

class EventsFilter extends StatefulWidget {
  List<SportCategory> sports;

  EventsFilter({Key? key, required this.sports}) : super(key: key);

  @override
  State<EventsFilter> createState() => _EventsFilterState();
}

class _EventsFilterState extends State<EventsFilter> {
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: height / 11,
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.sports.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomButton(
                    text: widget.sports[index].name,
                    isClicked: widget.sports[index].isSelected,
                    onPressed: (() {
                      setState(() {
                        if (widget.sports[index].name == "WSZYSTKO") {
                          bool allSelected = widget.sports[index].isSelected;

                          if (allSelected) {
                            widget.sports.forEach((element) {
                              element.isSelected = false;
                            });
                          } else {
                            widget.sports.forEach((element) {
                              element.isSelected = true;
                            });
                          }
                        } else {
                          widget.sports[index].isSelected =
                              !widget.sports[index].isSelected;
                        }

                        widget.sports.sort(((a, b) {
                          if (a.isSelected == b.isSelected) {
                            return a.importance.compareTo(b.importance);
                          } else {
                            return a.isSelected ? -1 : 1;
                          }
                        }));
                      });
                    }));
              }),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.sports.length,
            itemBuilder: (context, index) {
              if (widget.sports[index].name != "WSZYSTKO") {
                return Visibility(
                  visible: widget.sports[index].isSelected,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 0.2))),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.sports[index].isDropdownOpen =
                                !widget.sports[index].isDropdownOpen;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: height / 20,
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.sports[index].name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: width / 11,
                                      height: height / 25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: Colors.grey, width: 0.2)),
                                      child: widget.sports[index].isDropdownOpen
                                          ? Icon(Icons.arrow_drop_up)
                                          : Icon(Icons.arrow_drop_down),
                                    ),
                                  ]),
                            ),
                            Visibility(
                              visible: widget.sports[index].isDropdownOpen,
                              child: Column(
                                children: [
                                  Container(
                                    width: 200.0,
                                    height: 40.0,
                                    color: Colors.grey[300],
                                    alignment: Alignment.center,
                                    child: Text('Dropdown Item 1'),
                                  ),
                                  Container(
                                    width: 200.0,
                                    height: 40.0,
                                    color: Colors.grey[300],
                                    alignment: Alignment.center,
                                    child: Text('Dropdown Item 2'),
                                  ),
                                  Container(
                                    width: 200.0,
                                    height: 40.0,
                                    color: Colors.grey[300],
                                    alignment: Alignment.center,
                                    child: Text('Dropdown Item 3'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}
