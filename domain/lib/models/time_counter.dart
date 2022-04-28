import 'package:domain/models/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TimeCounter extends Equatable {
  final String id;
  final String title;
  final DateTime createdAt;
  final AppTheme theme;

  TimeCounter.generated({
    required this.title,
    this.theme = AppTheme.happyCyan,
    DateTime? createdAt,
  })  : id = Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  TimeCounter({
    required this.id,
    required this.title,
    required this.createdAt,
    this.theme = AppTheme.happyCyan,
  });

  static TimeCounter get empty => TimeCounter(
        id: Uuid().v4(),
        title: DEFAULT_TITLE,
        createdAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        theme,
      ];

  TimeCounter copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    AppTheme? theme,
  }) {
    return TimeCounter(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      theme: theme ?? this.theme,
    );
  }
}

const String DEFAULT_TITLE = "Days without incidents";
