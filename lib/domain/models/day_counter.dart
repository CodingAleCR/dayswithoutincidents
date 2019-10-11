class DayCounter {
  final String title;
  final DateTime incident;

  DayCounter(this.title, this.incident);

  factory DayCounter.empty() {
    return DayCounter(DEFAULT_TITLE, DateTime.now());
  }
}

const String DEFAULT_TITLE = "Days without incidents";
