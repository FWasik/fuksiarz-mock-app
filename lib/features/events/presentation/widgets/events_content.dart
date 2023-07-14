import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/common/loading_widget.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';

import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_category_button.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_category.dart';

class EventsContent extends StatefulWidget {
  const EventsContent({Key? key}) : super(key: key);

  @override
  State<EventsContent> createState() => _EventsContentState();
}

class _EventsContentState extends State<EventsContent> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is FetchedEventsState) {
          List<SportCategory1Name> categories = state.categories;

          return Container(
            color: Colors.grey[100]!,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]!))),
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
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return EventsCategoryButton(
                                  category: categories[index],
                                  onPressed: (() {
                                    BlocProvider.of<EventsBloc>(context).add(
                                      CategoriesFilterEvent(
                                          currentCategory: categories[index],
                                          categories: categories),
                                    );
                                  }));
                            }),
                      ),
                    ]),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      if (categories[index].name != "WSZYSTKO") {
                        return EventsCategory(
                            state: state, category: categories[index]);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is LoadingState) {
          return SizedBox(
            height: height * 0.7,
            child: const LoadingWidget(),
          );
        } else if (state is ErrorState) {
          return SizedBox(
            height: height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _showOptionsDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<EventsBloc, EventsState>(
              builder: (context, state) {
            if (state is FetchedEventsState) {
              List<SportCategory1Name> categories = state.categories;

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
                        itemCount: categories.length,
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
                                  value: categories[index].isSelected,
                                  onChanged: (bool? value) {
                                    BlocProvider.of<EventsBloc>(context).add(
                                        CategoriesFilterEvent(
                                            currentCategory: categories[index],
                                            categories: categories));
                                  },
                                  title: Text(
                                    categories[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: categories[index].isSelected
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
