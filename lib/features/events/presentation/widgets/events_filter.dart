import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_button.dart';

class EventFilter extends StatefulWidget {
  List<dynamic> sports;

  EventFilter({Key? key, required this.sports}) : super(key: key);

  @override
  State<EventFilter> createState() => _EventFilterState();
}

class _EventFilterState extends State<EventFilter> {
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
                    text: widget.sports[index][0],
                    isClicked: widget.sports[index][1],
                    onPressed: (() {
                      setState(() {
                        widget.sports[index][1] = !widget.sports[index][1];

                        widget.sports.sort(((a, b) => a[1] ? -1 : 1));
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
