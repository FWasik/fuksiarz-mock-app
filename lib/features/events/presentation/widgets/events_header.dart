import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Stack(
        children: [
          Container(
            height: height / 9.0,
            color: Colors.red,
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 18),
            child: Container(
              height: height / 9.5,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 14, vertical: height / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height / 12,
                      child: Image.asset(
                        "assets/logo-bck.png",
                        width: width / 3.25,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8),
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
          ),
        ],
      ),
    );
  }
}
