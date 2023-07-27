import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 8.0,
                  backgroundColor: Colors.red[100],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.redAccent[700]!),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                "DAJ NAM CHWILĘ",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                "PRZESZUKUJEMY BAZĘ DANYCH",
              ),
            )
          ],
        ),
      ),
    );
  }
}
