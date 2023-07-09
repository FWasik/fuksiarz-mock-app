import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/data/datasources/events_data_source.dart';
import 'package:fuksiarz_mock_app/features/events/data/repositories/events_repo_impl.dart';
import 'package:fuksiarz_mock_app/features/events/domain/usecases/get_events.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/pages/events_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsBloc>(
          create: (context) => EventsBloc(
            getEvents: GetEvents(
              repository: EventsRepoImpl(eventsDataSource: EventsDataSource()),
            ),
          )..add(FetchedEventsEvent()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.red),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
