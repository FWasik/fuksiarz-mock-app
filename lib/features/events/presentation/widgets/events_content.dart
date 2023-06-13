import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/categories_filter/categories_filter_bloc.dart';

import 'package:fuksiarz_mock_app/features/events/presentation/widgets/category.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_button.dart';

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

    return BlocBuilder<CategoriesFilterBloc, CategoriesFilterState>(
        builder: (contextCategories, stateCategories) {
      if (stateCategories is CategoriesFilterInital) {
        List<SportCategory> sports = stateCategories.sports;

        return Column(
          children: [
            Container(
              height: height / 11,
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
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
                        itemCount: sports.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomButton(
                              text: sports[index].name,
                              isClicked: sports[index].isSelected,
                              onPressed: (() {
                                BlocProvider.of<CategoriesFilterBloc>(
                                        contextCategories)
                                    .add(CategriesFilterRequested(
                                        index: index, currentSports: sports));
                              }));
                        }),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: sports.length,
                  itemBuilder: (context, index) {
                    if (sports[index].name != "WSZYSTKO") {
                      return Visibility(
                        visible: sports[index].isSelected,
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sports[index].isDropdownOpen =
                                      !sports[index].isDropdownOpen;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: height / 20,
                                    alignment: Alignment.center,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            sports[index].name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: width / 11,
                                            height: height / 25,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0.2)),
                                            child: sports[index].isDropdownOpen
                                                ? const Icon(
                                                    Icons.keyboard_arrow_up)
                                                : const Icon(
                                                    Icons.keyboard_arrow_down),
                                          ),
                                        ]),
                                  ),
                                  Visibility(
                                    visible: sports[index].isDropdownOpen,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 200.0,
                                          height: 40.0,
                                          color: Colors.grey[300],
                                          alignment: Alignment.center,
                                          child: Text('Dropdown Item 1'),
                                        ),
                                        Container(
                                          width: 200.0,
                                          height: 40.0,
                                          color: Colors.grey[300],
                                          alignment: Alignment.center,
                                          child: Text('Dropdown Item 2'),
                                        ),
                                        Container(
                                          width: 200.0,
                                          height: 40.0,
                                          color: Colors.grey[300],
                                          alignment: Alignment.center,
                                          child: Text('Dropdown Item 3'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        );
      } else {
        return Container();
      }
    });
  }

  void _showOptionsDialog() {
    final double height = MediaQuery.of(context).size.height;

    showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<CategoriesFilterBloc, CategoriesFilterState>(
              builder: (contextCategories, stateCategories) {
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
                      itemCount: sports.length,
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
                                value: sports[index].isSelected,
                                onChanged: (bool? value) {
                                  BlocProvider.of<CategoriesFilterBloc>(
                                          contextCategories)
                                      .add(CategriesFilterRequested(
                                          index: index, currentSports: sports));
                                },
                                title: Text(
                                  sports[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: sports[index].isSelected
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              )),
                        );
                      }),
                ),
              ),
            );
          });
        });
  }
}
