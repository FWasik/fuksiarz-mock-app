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

  int currenctIndex = 0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.red,
              ),
            ),
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/logo-bck.png",
                        width: 130,
                        height: 100,
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
      ),
      body: DefaultTabController(
          length: 6,
          child: ListView(
            children: [
              SearchInput(searchController: searchController),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 245, 245),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (index) {
                    setState(() {
                      currenctIndex = index;
                    });

                    print(currenctIndex);
                  },
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4.0,
                        spreadRadius: 0.0,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      child: Text(
                        "Oferta",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Moje",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Live",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Hot",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Cashback",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
              Builder(builder: (_) {
                if (currenctIndex == 1) {
                  return EventsContent();
                } else {
                  return Icon(Icons.abc);
                }
              })
            ],
          )),
    );
  }
}
