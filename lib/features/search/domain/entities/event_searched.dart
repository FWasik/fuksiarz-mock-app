import 'package:fuksiarz_mock_app/common/events_base.dart';

class EventSearched extends EventBase {
  final String area;

  const EventSearched({
    required eventName,
    required eventTime,
    required eventDate,
    required category3Name,
    required this.area,
  }) : super(
          eventName: eventName,
          eventTime: eventTime,
          eventDate: eventDate,
          category3Name: category3Name,
        );

  @override
  List<Object?> get props =>
      [eventName, eventTime, eventDate, category3Name, area];
}
