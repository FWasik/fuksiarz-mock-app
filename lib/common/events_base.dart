import 'package:equatable/equatable.dart';

abstract class EventBase extends Equatable {
  final String eventName;
  final String eventTime;
  final String eventDate;
  final String category3Name;

  const EventBase({
    required this.eventName,
    required this.eventTime,
    required this.eventDate,
    required this.category3Name,
  });

  @override
  List<Object?> get props => [eventName, eventTime, eventDate, category3Name];
}
