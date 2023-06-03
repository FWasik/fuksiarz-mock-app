import 'package:flutter/material.dart';

class EventFilter extends StatefulWidget {
  const EventFilter({Key? key}) : super(key: key);

  @override
  State<EventFilter> createState() => _EventFilterState();
}

class _EventFilterState extends State<EventFilter>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(children: [
        TabBar(
          tabs: [
            Tab(
                child: OutlinedButton(
                    child: Text("Piłka Nożna"), onPressed: () {})),
            Tab(
                child: OutlinedButton(
                    child: Text("Koszykówka"), onPressed: () {})),
            Tab(
                child:
                    OutlinedButton(child: Text("Siatkówka"), onPressed: () {})),
            Tab(child: OutlinedButton(child: Text("Tenis"), onPressed: () {})),
          ],
        ),
        Expanded(
          child: TabBarView(children: [
            Text("Piłka Nozna"),
            Text("Koszykówka"),
            Text("Siatkówka"),
            Text("Tenis"),
          ]),
        )
      ]),
    );
  }
}
