import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                strokeWidth: 8.0,
                backgroundColor: Colors.red[100],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              "DAJ MI CHWILE...",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              "PRZESZUKUJĘ BAZE...",
            ),
          )
        ],
      ),
    );
  }
}
