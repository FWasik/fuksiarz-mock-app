import 'package:fuksiarz_mock_app/features/events/domain/entities/outcome.dart';

class OutcomeDTO extends Outcome {
  const OutcomeDTO({required outcomeName, required outcomeOdds})
      : super(outcomeName: outcomeName, outcomeOdds: outcomeOdds);

  factory OutcomeDTO.fromJson(Map<String, dynamic> json) {
    return OutcomeDTO(
        outcomeName: json["outcomeName"], outcomeOdds: json["outcomeOdds"]);
  }
}
