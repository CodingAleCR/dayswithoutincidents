import 'package:intl/intl.dart';

/// Convenience date extensions
extension FormatDate on DateTime {
  /// Lists all the months in order.
  List<int> get months => [
        DateTime.january,
        DateTime.february,
        DateTime.march,
        DateTime.april,
        DateTime.may,
        DateTime.june,
        DateTime.july,
        DateTime.august,
        DateTime.september,
        DateTime.october,
        DateTime.november,
        DateTime.december,
      ];

  /// Determines if a DateTime is the same day as another DateTime
  bool isSameDay(DateTime? other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }

  /// Prints the DateTime as a formatted string.
  String toFormattedString(String format) {
    return DateFormat(format).format(this);
  }

  /// Prints the DateTime as a formatted string.
  String toLocalizedString() {
    return DateFormat.yMd().add_jm().format(this);
  }
}
