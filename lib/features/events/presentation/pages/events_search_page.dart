import 'package:flutter/material.dart';
import 'package:fuksiarz_mock_app/features/events/presentation/widgets/events_header.dart';

class EventsSearchPage extends StatefulWidget {
  const EventsSearchPage({super.key});

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
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 110,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: EventsHeader(
              appBarWidget:
                  appBarWidget(context, _controller, _showSuffixIcon, width)),
        ),
        body: Container(
          color: Colors.red,
          height: 200,
          width: 200,
        ));
  }
}

Widget appBarWidget(BuildContext context, TextEditingController controller,
    bool showSuffixIcon, double width) {
  return Positioned(
    top: 50,
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.grey[100]!,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
        ),
      ),
      child: TextField(
        controller: controller,
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
              Navigator.pop(context);
            },
          ),
          suffixIcon: showSuffixIcon
              ? IconButton(
                  onPressed: controller.clear,
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
