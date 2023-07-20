import 'package:flutter/material.dart';

class SearchNoDataFoundWidget extends StatelessWidget {
  const SearchNoDataFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.grey[50],
      width: width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.warning,
              size: 80.0,
              color: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "BRAK WYNIKÓW",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "SPRÓBUJ INNEGO ZAPYTANIA",
            ),
          )
        ],
      ),
    );
  }
}
