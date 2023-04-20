import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_header.dart';
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
    return Scaffold(
        body: Column(
      children: [
        const Header(),
        SearchInput(
          searchController: searchController,
        )
      ],
    ));
  }
}
