import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_header.dart';
import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';
import 'package:fuksiarz_mock_app/features/search/presentation/bloc/search_bloc.dart';

class EventsSearchPage extends StatefulWidget {
  const EventsSearchPage({super.key});

  @override
  State<EventsSearchPage> createState() => _EventsSearchPageState();
}

class _EventsSearchPageState extends State<EventsSearchPage> {
  final TextEditingController _controller = TextEditingController();
  bool _showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showSuffixIcon = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 110,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: EventsHeader(
              appBarWidget:
                  appBarWidget(context, _controller, _showSuffixIcon, width)),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is FetchedEventsSearchedState) {
              return Container(
                padding: const EdgeInsets.only(
                    bottom: 15.0, left: 15.0, right: 15.0),
                color: Colors.grey[100]!,
                child: ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      SportCategory3Name category = state.categories[index];

                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: category.events.length,
                              itemBuilder: (context, indexEvent) {
                                EventSearched event = category
                                    .events[indexEvent] as EventSearched;

                                return EventsEventGame(
                                    subsubcategory: category,
                                    event: event,
                                    eventGame: null);
                              })
                        ],
                      );
                    }),
              );
            } else if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey[100]);
            }
          },
        ));
  }
}

Widget appBarWidget(BuildContext context, TextEditingController controller,
    bool showSuffixIcon, double width) {
  return Positioned(
    top: 50,
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.grey[100]!,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          print(value);
          if (value.length > 3) {
            BlocProvider.of<SearchBloc>(context).add(
              FetchedEventsSearchedEvent(pattern: value),
            );
          }
        },
        style: const TextStyle(
          backgroundColor: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          border: const OutlineInputBorder(),
          prefixIcon: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.grey[350]!,
              size: 32.0,
            ),
            onPressed: () {
              BlocProvider.of<SearchBloc>(context)
                  .add(ClearEventsSearchedEvent());
              Navigator.pop(context);
            },
          ),
          suffixIcon: showSuffixIcon
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    BlocProvider.of<SearchBloc>(context)
                        .add(ClearEventsSearchedEvent());
                  },
                  icon: Icon(
                    Icons.highlight_off,
                    color: Colors.grey[350]!,
                  ),
                )
              : null,
        ),
      ),
    ),
  );
}
