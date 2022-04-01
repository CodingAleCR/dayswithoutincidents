import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TimeCounter extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;

  TimeCounter.generated({
    required this.title,
    DateTime? createdAt,
  })  : id = Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  TimeCounter({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  static get empty => TimeCounter(
        id: Uuid().v4(),
        title: DEFAULT_TITLE,
        createdAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
      ];

  TimeCounter copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
  }) {
    return TimeCounter(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

const String DEFAULT_TITLE = "Days without incidents";
