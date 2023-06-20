import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event.dart';
import 'package:fuksiarz_mock_app/features/events/domain/entities/event_game.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/categories/events_football.dart';

import 'package:fuksiarz_mock_app/features/events/presentation/widgets/category.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_button.dart';

class EventsCategory extends StatefulWidget {
  final SportCategory category;

  const EventsCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<EventsCategory> createState() => _EventsCategoryState();
}

class _EventsCategoryState extends State<EventsCategory> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is FetchedEventsState && widget.category.isSelected) {
          List<SportSubcategory> subcategoriesFiltered = widget
              .category.subcategories
              .where((subcategory) => subcategory.isSelected)
              .toList();

          return Container(
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: height / 20,
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.category.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(flex: 8),
                          GestureDetector(
                            onTap: () {
                              int index = state.categories.indexWhere(
                                  (element) =>
                                      element.name == widget.category.name);

                              _showOptionsDialog(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              width: width / 5.5,
                              height: height / 22,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.tune, size: 23.0),
                                    Text(
                                      "LIGI",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          ),
                          Spacer(flex: 1),
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   widget.category.isDropdownOpen =
                              //       !widget.category.isDropdownOpen;
                              // });

                              BlocProvider.of<EventsBloc>(context).add(
                                DropdownEventChangeEvent(
                                    dropdownValue:
                                        !widget.category.isDropdownOpen,
                                    currentCategory: widget.category,
                                    categories: state.categories),
                              );
                            },
                            child: Container(
                              width: width / 10,
                              height: height / 22,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2)),
                              child: widget.category.isDropdownOpen
                                  ? const Icon(Icons.keyboard_arrow_up)
                                  : const Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                        ]),
                  ),
                  widget.category.isDropdownOpen
                      ? DefaultTabController(
                          length: widget.category.typesOfEventGames.length,
                          child: Column(
                            children: [
                              TabBar(
                                isScrollable: true,
                                onTap: (index) {
                                  // setState(() {
                                  //   String currentType =
                                  //       widget.category.typesOfEvents[index];
                                  // });

                                  BlocProvider.of<EventsBloc>(context).add(
                                    TypeEventFilterEvent(
                                        type: widget
                                            .category.typesOfEventGames[index],
                                        currentCategory: widget.category,
                                        categories: state.categories),
                                  );
                                },
                                tabs: widget.category.typesOfEventGames
                                    .map((type) {
                                  return Tab(
                                    child: Text(
                                      type,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                              ...subcategoriesFiltered.map((subcategory) {
                                if (subcategory.eventGames.isNotEmpty) {
                                  return buildExpansionPanel(
                                      widget.category, subcategory);
                                } else {
                                  return Container();
                                }
                              }).toList()
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _showOptionsDialog(int indexCategory) {
    final double height = MediaQuery.of(context).size.height;

    showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<EventsBloc, EventsState>(
              builder: (context, state) {
            if (state is FetchedEventsState) {
              List<SportSubcategory> subcategories =
                  state.categories[indexCategory].subcategories;

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
                        itemCount: subcategories.length,
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
                                  value: subcategories[index].isSelected,
                                  onChanged: (bool? value) {
                                    BlocProvider.of<EventsBloc>(context).add(
                                        SubcategoriesFilterEvent(
                                            indexSubcategory: index,
                                            indexCategory: indexCategory,
                                            categories: state.categories));
                                  },
                                  title: Text(
                                    subcategories[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: subcategories[index].isSelected
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

Widget buildExpansionPanel(
    SportCategory category, SportSubcategory subcategory) {
  return BlocBuilder<EventsBloc, EventsState>(
    builder: (context, state) {
      if (state is FetchedEventsState && subcategory.eventGames.isNotEmpty) {
        var filteredEventGames = subcategory.eventGames
            .where((eventGame) => eventGame.gameName == category.currentType)
            .toList();

        return ExpansionPanelList(
          elevation: 1,
          expandedHeaderPadding: EdgeInsets.all(0),
          expansionCallback: (int index, bool isExpanded) {
            BlocProvider.of<EventsBloc>(context).add(
              ExpansionEventChangeEvent(
                  expansionValue: !subcategory.isExpanded,
                  currentCategory: category,
                  currentSubcategory: subcategory,
                  categories: state.categories),
            );
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(subcategory.name),
                );
              },
              body: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredEventGames.length,
                itemBuilder: (BuildContext context, int indexGame) {
                  EventGame eventGame = filteredEventGames[indexGame];

                  try {
                    if (eventGame.outcomes.length < 4) {
                      return EventsFootball(eventGame: eventGame);
                    }
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                },
              ),
              isExpanded: subcategory.isExpanded,
            ),
          ],
        );
      } else {
        return Container();
      }
    },
  );
} 


// return Container(
  //           decoration: const BoxDecoration(
  //               border:
  //                   Border(bottom: BorderSide(width: 1, color: Colors.grey))),
  //           child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: ExpansionPanelList(
  //                 elevation: 1,
  //                 expandedHeaderPadding: EdgeInsets.all(0),
  //                 expansionCallback: (int index, bool isExpanded) {
  //                   BlocProvider.of<EventsBloc>(context).add(
  //                     DropdownEventChangeEvent(
  //                         dropdownValue: !widget.category.isDropdownOpen,
  //                         currentCategory: widget.category,
  //                         categories: state.categories),
  //                   );
  //                 },
  //                 children: [
  //                   ExpansionPanel(
  //                     headerBuilder: (BuildContext context, bool isExpanded) {
  //                       return Text(widget.category.name);
  //                     },
  //                     body: DefaultTabController(
  //                       length: widget.category.typesOfEvents.length,
  //                       child: Column(
  //                         children: [
  //                           TabBar(
  //                             isScrollable: true,
  //                             controller: _tabController,
  //                             onTap: (index) {
  //                               // setState(() {
  //                               //   String currentType =
  //                               //       widget.category.typesOfEvents[index];
  //                               // });

  //                               BlocProvider.of<EventsBloc>(context).add(
  //                                 TypeEventFilterEvent(
  //                                     type:
  //                                         widget.category.typesOfEvents[index],
  //                                     currentCategory: widget.category,
  //                                     categories: state.categories),
  //                               );
  //                             },
  //                             tabs: widget.category.typesOfEvents.map((type) {
  //                               return Tab(
  //                                 child: Text(
  //                                   type,
  //                                   style: const TextStyle(color: Colors.black),
  //                                 ),
  //                               );
  //                             }).toList(),
  //                           ),
  //                           ListView.builder(
  //                             shrinkWrap: true,
  //                             itemCount: widget.category.events.length,
  //                             physics: const NeverScrollableScrollPhysics(),
  //                             itemBuilder: (context, indexEvent) {
  //                               Event currentEvent =
  //                                   widget.category.events[indexEvent];

  //                               final filteredEventGames = currentEvent
  //                                   .eventGames
  //                                   .where((game) =>
  //                                       game.gameName ==
  //                                       widget.category.currentType)
  //                                   .toList();
  //                               return ListView.builder(
  //                                 shrinkWrap: true,
  //                                 itemCount: filteredEventGames.length,
  //                                 physics: const NeverScrollableScrollPhysics(),
  //                                 itemBuilder: (context, indexEventGame) {
  //                                   EventGame eventGame =
  //                                       filteredEventGames[indexEventGame];

  //                                   if (eventGame.outcomes.length < 4) {
  //                                     return EventsFootball(
  //                                         event: currentEvent,
  //                                         eventGame: eventGame);
  //                                   }
  //                                 },
  //                               );
  //                             },
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     isExpanded: widget.category.isDropdownOpen,
  //                   ),
  //                 ],
  //               )),
  //         );