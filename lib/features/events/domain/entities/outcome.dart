import 'package:equatable/equatable.dart';

class Outcome extends Equatable {
  String outcomeName;
  final double outcomeOdds;
  bool isClicked = false;

  Outcome({required this.outcomeName, required this.outcomeOdds});

  @override
  List<Object?> get props => [outcomeName, outcomeOdds];
}
