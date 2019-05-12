class DayCounter {
  final String title;
  final DateTime incident;

  DayCounter(this.title, this.incident);

  static final DayCounter EMPTY_COUNTER =
      DayCounter(DEFAULT_TITLE, DateTime.now());
}

const String DEFAULT_TITLE = "Days without incidents";
