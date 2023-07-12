import 'package:fuksiarz_mock_app/features/search/domain/entities/event_searched.dart';
import 'package:intl/intl.dart';

class EventSearchedDTO extends EventSearched {
  const EventSearchedDTO({
    required eventName,
    required eventTime,
    required eventDate,
    required category3Name,
    required area,
  }) : super(
          eventName: eventName,
          eventTime: eventTime,
          eventDate: eventDate,
          category3Name: category3Name,
          area: area,
        );

  factory EventSearchedDTO.fromJson(Map<String, dynamic> json) {
    String name = json["name"];

    DateTime dt =
        DateTime.fromMillisecondsSinceEpoch(json["eventStart"]).toLocal();

    return EventSearchedDTO(
        eventName: name.replaceAll(" (live)", ""),
        eventTime: DateFormat("HH:mm").format(dt),
        eventDate: DateFormat("dd.MM").format(dt),
        category3Name: json["extras"]["CATEGORY_NAME_3"],
        area: json["area"]);
  }
}
