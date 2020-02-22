import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TimeCounter extends Equatable {
  final String title;
  final DateTime incident;

  TimeCounter({@required this.title, this.incident});

  factory TimeCounter.empty() {
    return TimeCounter(title: DEFAULT_TITLE, incident: DateTime.now());
  }

  @override
  List<Object> get props => [title, incident];
}

const String DEFAULT_TITLE = "Days without incidents";
