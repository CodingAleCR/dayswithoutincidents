import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TimeCounter extends Equatable {
  final String id;
  final String title;
  final DateTime? incident;

  TimeCounter.generated({required this.title, this.incident})
      : id = Uuid().v4();

  TimeCounter({required this.id, required this.title, this.incident});

  factory TimeCounter.empty() {
    return TimeCounter(
      id: Uuid().v4(),
      title: DEFAULT_TITLE,
      incident: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [id, title, incident];
}

const String DEFAULT_TITLE = "Days without incidents";
