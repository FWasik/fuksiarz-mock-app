import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_content.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_main_tab_bars.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // sports.sort(((a, b) {
    //   if (a.isSelected == b.isSelected) {
    //     return a.importance.compareTo(b.importance);
    //   } else {
    //     return a.isSelected ? -1 : 1;
    //   }
    // }));

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: height / 10,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: height / 40),
              child: OutlinedButton.icon(
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
            ),
          ],
          title: SizedBox(
            height: height / 5,
            child: Image.asset(
              "assets/logo-bck.png",
              width: width / 3.25,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
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
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height / 6.5),
            child: Material(
              color: Colors.white,
              child: Column(
                children: [
                  SearchInput(
                    searchController: searchController,
                  ),
                  const EventsMainTabBars()
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            EventsContent(),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
