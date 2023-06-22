import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/categories/events_football.dart';

import 'package:fuksiarz_mock_app/features/events/presentation/widgets/category.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_button.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_category.dart';

class EventsContent extends StatefulWidget {
  const EventsContent({Key? key}) : super(key: key);

  @override
  State<EventsContent> createState() => _EventsContentState();
}

class _EventsContentState extends State<EventsContent> {
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is FetchedEventsState) {
          List<SportCategory> categoriesEvents = state.categories;

          return Container(
            color: const Color.fromARGB(255, 246, 246, 246),
            child: Column(
              children: [
                Container(
                  height: 70.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      SizedBox(
                          width: 40,
                          child: IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: _showOptionsDialog,
                          )),
                      SizedBox(
                        width: width - 60,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoriesEvents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomButton(
                                  text: categoriesEvents[index].name,
                                  isClicked: categoriesEvents[index].isSelected,
                                  onPressed: (() {
                                    BlocProvider.of<EventsBloc>(context).add(
                                      CategoriesFilterEvent(
                                          index: index,
                                          categories: categoriesEvents),
                                    );
                                  }));
                            }),
                      ),
                    ]),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoriesEvents.length,
                      itemBuilder: (context, index) {
                        if (categoriesEvents[index].name != "WSZYSTKO") {
                          return EventsCategory(
                              category: categoriesEvents[index]);
                        } else {
                          return Container();
                        }
                      }),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _showOptionsDialog() {
    final double height = MediaQuery.of(context).size.height;

    showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<EventsBloc, EventsState>(
              builder: (context, state) {
            if (state is FetchedEventsState) {
              List<SportCategory> categoriesEvents = state.categories;

              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.down,
                onDismissed: (direction) {
                  Navigator.pop(context);
                },
                child: AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  titlePadding: EdgeInsets.zero,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  title: SizedBox(
                    height: height / 12,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(
                          child: Text(
                            "Dyscypliny",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        )
                      ],
                    ),
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: categoriesEvents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: CheckboxListTile(
                                  activeColor: Colors.black,
                                  value: categoriesEvents[index].isSelected,
                                  onChanged: (bool? value) {
                                    BlocProvider.of<EventsBloc>(context).add(
                                        CategoriesFilterEvent(
                                            index: index,
                                            categories: categoriesEvents));
                                  },
                                  title: Text(
                                    categoriesEvents[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            categoriesEvents[index].isSelected
                                                ? Colors.black
                                                : Colors.grey),
                                  ),
                                )),
                          );
                        }),
                  ),
                ),
              );
            } else {
              return Container();
            }
          });
        });
  }
}
