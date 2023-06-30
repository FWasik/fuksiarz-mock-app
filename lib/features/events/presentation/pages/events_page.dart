import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_content.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_header.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_main_tab_bars.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();

  int currentIndex = 0;

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
          toolbarHeight: 80, elevation: 0, flexibleSpace: const EventsHeader()),
      body: DefaultTabController(
          length: 8,
          child: ListView(
            children: [
              SearchInput(searchController: searchController),
              EventsMainTabBars(changeIndexCallback: _changeIndexCallback),
              Builder(builder: (_) {
                if (currentIndex == 1) {
                  return const EventsContent();
                } else {
                  return const Icon(Icons.abc);
                }
              })
            ],
          )),
    );
  }

  void _changeIndexCallback(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
