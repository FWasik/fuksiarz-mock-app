import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_mock_app/common/custom_error_widget.dart';
import 'package:fuksiarz_mock_app/common/loading_widget.dart';
import 'package:fuksiarz_mock_app/common/events_header.dart';
import 'package:fuksiarz_mock_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:fuksiarz_mock_app/features/search/presentation/widgets/search_content_widget.dart';
import 'package:fuksiarz_mock_app/features/search/presentation/widgets/search_no_data_found_widget.dart';

class EventsSearchPage extends StatefulWidget {
  const EventsSearchPage({Key? key}) : super(key: key);

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
    final double height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;

    double toolbarHeight;

    if (height > 1000 || height < 700) {
      toolbarHeight = 120;
    } else {
      toolbarHeight = 100;
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: toolbarHeight,
          automaticallyImplyLeading: false,
          flexibleSpace: EventsHeader(
            appBarWidget: appBarWidget(_controller, _showSuffixIcon, width),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is FetchedEventsSearchedState &&
                state.categories.isEmpty) {
              return const SearchNoDataFoundWidget();
            } else if (state is FetchedEventsSearchedState) {
              return SearchContentWidget(state: state);
            } else if (state is LoadingState &&
                orientation == Orientation.portrait) {
              return const LoadingWidget();
            } else if (state is ErrorState) {
              return CustomErrorWidget(errorMessage: state.error);
            } else {
              return Container();
            }
          },
        ));
  }

  Widget appBarWidget(
      TextEditingController controller, bool showSuffixIcon, double width) {
    return Positioned(
      top: 50,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
        ),
        child: TextField(
          controller: controller,
          onChanged: (value) {
            if (value.length > 2) {
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
}
