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
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 0.2))),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              SizedBox(
                  width: 40,
                  child: IconButton(
                    icon: Icon(Icons.tune),
                    onPressed: () {
                      _showOptionsDialog(widget.sports);
                    },
                  )),
              SizedBox(
                width: width - 60,
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
                                bool allSelected =
                                    widget.sports[index].isSelected;

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
            ]),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.sports.length,
            itemBuilder: (context, index) {
              return Visibility(
                visible: widget.sports[index].isSelected,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.2))),
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
            },
          ),
        )
      ],
    );
  }

  void _showOptionsDialog(List<SportCategory> sports) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (contextState, StateSetter setState) {
          return Dismissible(
            key: UniqueKey(),
            direction:
                DismissDirection.down, // Allow dismissal by dragging down
            onDismissed: (direction) {
              Navigator.pop(context); // Close the dialog
            },
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero, // Remove default padding
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              title: Row(children: [
                Expanded(
                    child: Text("Dyscypliny",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                )
              ]),
              content: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: sports.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: CheckboxListTile(
                                activeColor: Colors.black,
                                value: sports[index].isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (sports[index].name == "WSZYSTKO") {
                                      bool allSelected =
                                          sports[index].isSelected;

                                      if (allSelected) {
                                        sports.forEach((element) {
                                          element.isSelected = false;
                                        });
                                      } else {
                                        sports.forEach((element) {
                                          element.isSelected = true;
                                        });
                                      }
                                    } else {
                                      sports[index].isSelected =
                                          !sports[index].isSelected;
                                    }

                                    sports.sort(((a, b) {
                                      if (a.isSelected == b.isSelected) {
                                        return a.importance
                                            .compareTo(b.importance);
                                      } else {
                                        return a.isSelected ? -1 : 1;
                                      }
                                    }));
                                  });
                                },
                                title: Text(
                                  sports[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: sports[index].isSelected
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              )),
                        );
                      })),
            ),
          );
        });
      },
    );
  }
}
