import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/common/custom_error_widget.dart';
import 'package:fuksiarz_mock_app/common/dialog.dart';
import 'package:fuksiarz_mock_app/common/loading_widget.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';

import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_category_button.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_category_widget.dart';

class EventsContentWidget extends StatelessWidget {
  const EventsContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is FetchedEventsState) {
          List<SportCategory1Name> categories = state.categories;

          return Container(
            color: Colors.grey[50],
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]!))),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 40,
                          child: IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: () {
                              showOptionsDialog(context,
                                  disciplines(categories), "Dyscypliny");
                            },
                          )),
                      SizedBox(
                        width: width - 56,
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
                    ],
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    if (categories[index].name != "WSZYSTKO") {
                      return EventsCategoryWidget(
                          state: state, category: categories[index]);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          );
        } else if (state is LoadingState) {
          return SizedBox(
              width: width, height: height * 0.6, child: const LoadingWidget());
        } else if (state is ErrorState) {
          return CustomErrorWidget(errorMessage: state.error);
        } else {
          return Container();
        }
      },
    );
  }

  Widget disciplines(List<SportCategory1Name> categories) {
    return ListView.builder(
      key: const PageStorageKey<String>("controllerA"),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: CheckboxListTile(
              activeColor: Colors.black,
              value: categories[index].isSelected,
              onChanged: (bool? value) {
                BlocProvider.of<EventsBloc>(context).add(CategoriesFilterEvent(
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
            ),
          ),
        );
      },
    );
  }
}
