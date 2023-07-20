import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/common/category.dart';
import 'package:fuksiarz_mock_app/common/event_game_widget.dart';
import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';
import 'package:fuksiarz_mock_app/features/search/presentation/bloc/search_bloc.dart';

class SearchContentWidget extends StatelessWidget {
  final FetchedEventsSearchedState state;

  const SearchContentWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      color: Colors.grey[50],
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
                      EventSearched event =
                          category.events[indexEvent] as EventSearched;

                      return EventGameWidget(
                        subsubcategory: category,
                        event: event,
                      );
                    })
              ],
            );
          }),
    );
  }
}
