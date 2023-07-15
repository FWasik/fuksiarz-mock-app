import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';

void showOptionsDialog(BuildContext context, Widget widget, String name) {
  showDialog(
      context: context,
      builder: (_) {
        return BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
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
                      Positioned(
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                    width: MediaQuery.of(context).size.width, child: widget),
              ),
            );
          } else {
            return Container();
          }
        });
      });
}
