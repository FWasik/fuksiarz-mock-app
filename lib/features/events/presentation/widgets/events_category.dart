import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:fuksiarz_mock_app/common/event_game_widget.dart';

import 'package:fuksiarz_mock_app/common/category.dart';

class EventsCategory extends StatefulWidget {
  final FetchedEventsState state;
  final SportCategory1Name category;

  const EventsCategory({Key? key, required this.state, required this.category})
      : super(key: key);

  @override
  State<EventsCategory> createState() => _EventsCategoryState();
}

class _EventsCategoryState extends State<EventsCategory> {
  @override
  Widget build(BuildContext context) {
    if (widget.category.isSelected) {
      List<SportCategory2Name> filteredList = [];

      for (SportCategory2Name subcategory in widget.category.subcategories) {
        if (subcategory.subsubcategories.any((element) => element.isSelected)) {
          filteredList.add(subcategory);
        }
      }

      return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Text(
                  widget.category.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showOptionsDialog(widget.category);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          width: 75.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.grey[300]!)),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.tune, size: 20.0),
                                Text(
                                  "LIGI",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<EventsBloc>(context).add(
                            DropdownEventChangeEvent(
                                currentCategory: widget.category,
                                categories: widget.state.categories),
                          );
                        },
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: Colors.grey[300]!)),
                            child: Icon(
                              widget.category.isDropdownOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 30.0,
                            )),
                      ),
                    ],
                  ),
                )
              ]),
            ),
            widget.category.isDropdownOpen
                ? filteredList.isNotEmpty
                    ? DefaultTabController(
                        length: widget.category.gameNames!.length,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TabBar(
                                labelPadding: const EdgeInsets.only(
                                    right: 10.0,
                                    left: 10.0,
                                    top: 3.0,
                                    bottom: 15.0),
                                isScrollable: true,
                                indicatorColor:
                                    const Color.fromARGB(255, 109, 138, 188),
                                onTap: (index) {
                                  BlocProvider.of<EventsBloc>(context).add(
                                    GameNameEventFilterEvent(
                                        gameName:
                                            widget.category.gameNames![index],
                                        currentCategory: widget.category,
                                        categories: widget.state.categories),
                                  );
                                },
                                tabs: widget.category.gameNames!.map((type) {
                                  return Tab(
                                    height: 20.0,
                                    child: Text(
                                      type,
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            ...filteredList.expand((subcategory) {
                              return subcategory.subsubcategories
                                  .map((subsubcategory) {
                                return buildExpansionPanel(widget.category,
                                    subcategory, subsubcategory);
                              });
                            }).toList()
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[100],
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          height: 50,
                          child: const Center(
                            child: Text(
                                "Aktualnie nie ma żadnych wydarzeń w wybranej dyscyplinie"),
                          ),
                        ),
                      )
                : Container()
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void _showOptionsDialog(SportCategory1Name category) {
    showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<EventsBloc, EventsState>(
              builder: (context, state) {
            if (state is FetchedEventsState) {
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
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(
                          child: Text(
                            "Ligi",
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
                          shrinkWrap: true,
                          itemCount: category.subcategories.length,
                          itemBuilder:
                              (BuildContext context, int indexSubcategory) {
                            SportCategory2Name subcategory =
                                category.subcategories[indexSubcategory];
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: subcategory.subsubcategories.length,
                                itemBuilder: (BuildContext context,
                                    int indexSubsubcategory) {
                                  SportCategory3Name subsubcategory =
                                      subcategory.subsubcategories[
                                          indexSubsubcategory];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: CheckboxListTile(
                                          activeColor: Colors.black,
                                          value: subsubcategory.isSelected,
                                          onChanged: (bool? value) {
                                            BlocProvider.of<EventsBloc>(context)
                                                .add(SubcategoriesFilterEvent(
                                                    currentSubsubcategory:
                                                        subsubcategory,
                                                    currentCategory: category,
                                                    categories:
                                                        state.categories));
                                          },
                                          title: Text(
                                            "${subcategory.name} > ${subsubcategory.name}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: subsubcategory.isSelected
                                                    ? Colors.black
                                                    : Colors.grey),
                                          ),
                                        )),
                                  );
                                });
                          })),
                ),
              );
            } else {
              return Container();
            }
          });
        });
  }
}

Widget buildExpansionPanel(SportCategory1Name category,
    SportCategory2Name subcategory, SportCategory3Name subsubcategory) {
  return BlocBuilder<EventsBloc, EventsState>(
    builder: (context, state) {
      var areAnyEventGames = subsubcategory.events
          .expand((event) => (event as Event).eventGames)
          .where((eventGame) => eventGame.gameName == category.currentGameName)
          .toList();

      if (state is FetchedEventsState &&
          areAnyEventGames.isNotEmpty &&
          subsubcategory.isSelected) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            expandIconColor: Colors.black,
            expansionCallback: (int index, bool isExpanded) {
              BlocProvider.of<EventsBloc>(context).add(
                ExpansionEventChangeEvent(
                    currentSubsubcategory: subsubcategory,
                    categories: state.categories),
              );
            },
            children: [
              ExpansionPanel(
                backgroundColor: Colors.grey[100],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${subcategory.name} > ${subsubcategory.name}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subsubcategory.events.length,
                      itemBuilder: (BuildContext context, int indexEvent) {
                        Event event =
                            subsubcategory.events[indexEvent] as Event;

                        var filteredEventGames = event.eventGames
                            .where((eventGame) =>
                                eventGame.gameName == category.currentGameName)
                            .toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredEventGames.length,
                          itemBuilder: (BuildContext context, int indexGame) {
                            EventGame eventGame = filteredEventGames[indexGame];

                            return EventGameWidget(
                                subsubcategory: subsubcategory,
                                event: event,
                                eventGame: eventGame);
                          },
                        );
                      }),
                ),
                isExpanded: subsubcategory.isExpanded,
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    },
  );
}
