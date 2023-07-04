import 'package:flutter/material.dart';

class EventsHeader extends StatelessWidget {
  const EventsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.red,
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/logo-bck.png",
                  width: 130,
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  icon: const Icon(
                    Icons.add_circle_sharp,
                    color: Colors.red,
                    size: 28,
                  ),
                  label: const Text(
                    "21,37 zł",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
