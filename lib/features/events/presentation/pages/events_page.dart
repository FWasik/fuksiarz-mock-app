import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_content_widget.dart';
import 'package:fuksiarz_mock_app/common/events_header.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_custom_widget_switcher.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_search_input_navigator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    double toolbarHeight;

    if (height > 1000 || height < 700) {
      toolbarHeight = 100;
    } else {
      toolbarHeight = 80;
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        elevation: 0,
        flexibleSpace: EventsHeader(
          appBarWidget: appBarWidget(width),
        ),
      ),
      body: DefaultTabController(
          length: 6,
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<EventsBloc>(context).add(FetchedEventsEvent());
            },
            child: ListView(
              children: [
                const SearchInputNavigator(),
                EventsCustomWidgetSwitcher(
                    changeIndexCallback: _changeIndexCallback),
                Builder(builder: (_) {
                  if (currentIndex == 1) {
                    return const EventsContentWidget();
                  } else {
                    return const Icon(Icons.abc);
                  }
                })
              ],
            ),
          )),
    );
  }

  void _changeIndexCallback(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget appBarWidget(double width) {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              icon: Icon(
                Icons.add_circle_sharp,
                color: Colors.redAccent[700],
                size: 28,
              ),
              label: const Text(
                "21,37 zł",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
