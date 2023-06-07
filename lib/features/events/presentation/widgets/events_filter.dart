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

    return Column(
      children: [
        Container(
          height: height / 11,
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
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
                        widget.sports[index].isSelected =
                            !widget.sports[index].isSelected;

                        widget.sports.sort(((a, b) {
                          if (a.isSelected == b.isSelected) {
                            return a.name.compareTo(b.name);
                          } else {
                            return a.isSelected ? -1 : 1;
                          }
                        }));
                      });
                    }));
              }),
        ),
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       isDropdownOpen = !isDropdownOpen;
        //     });
        //   },
        //   child: Column(
        //     children: [
        //       AnimatedContainer(
        //         duration: Duration(milliseconds: 300),
        //         height: 40.0,
        //         color: Colors.grey[300],
        //         alignment: Alignment.center,
        //         child: Text('Click Me'),
        //       ),
        //       AnimatedOpacity(
        //         duration: Duration(milliseconds: 300),
        //         opacity: isDropdownOpen ? 1.0 : 0.0,
        //         child: Column(
        //           children: [
        //             AnimatedContainer(
        //               duration: Duration(milliseconds: 300),
        //               height: isDropdownOpen ? 40.0 : 0.0,
        //               color: Colors.grey[300],
        //               alignment: Alignment.center,
        //               child: Text('Dropdown Item 1'),
        //             ),
        //             AnimatedContainer(
        //               duration: Duration(milliseconds: 300),
        //               height: isDropdownOpen ? 40.0 : 0.0,
        //               color: Colors.grey[300],
        //               alignment: Alignment.center,
        //               child: Text('Dropdown Item 2'),
        //             ),
        //             AnimatedContainer(
        //               duration: Duration(milliseconds: 300),
        //               height: isDropdownOpen ? 40.0 : 0.0,
        //               color: Colors.grey[300],
        //               alignment: Alignment.center,
        //               child: Text('Dropdown Item 3'),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
