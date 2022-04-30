import 'package:domain/models/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// A time counter holds information about the time that has passed from a
/// certain date comparted to DateTime.now()
class TimeCounter extends Equatable {
  /// Standard Constructor
  const TimeCounter({
    required this.title,
    this.id = '',
    this.theme = AppTheme.happyCyan,
    this.createdAt,
  });

  /// Generates a new time counter with proper UUID initialization.
  TimeCounter.generated({
    required this.title,
    this.theme = AppTheme.happyCyan,
    DateTime? createdAt,
  })  : id = const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  /// Identification UUID string to compare a time counter.
  final String id;

  /// Title to be displayed for this time counter.
  final String title;

  /// Date of creation of the time counter.
  final DateTime? createdAt;

  /// Theme that the counter uses.
  final AppTheme theme;

  /// Representation of an empty Time Counter.
  static const TimeCounter empty = TimeCounter(title: kDefaultCounterTitle);

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        theme,
      ];

  /// Provides a copied instance of a time counter.
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

/// Defines the default time counter title used.
const String kDefaultCounterTitle = 'Days without incidents';
