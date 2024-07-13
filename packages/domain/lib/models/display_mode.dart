/// List of possible display modes available. This is used for displaying
/// counters in the main app screen.
enum DisplayModes {
  /// Displays counters in a pager. Swiping left or right to see others.
  carousel,

  /// Displays counters in a list. All counters visible in a single screen.
  list,

  /// Displays a header section with a featured/favorited counter on it. All counters are displayed in a list below.
  featured,
}

/// Convenience extensions for boolean comparisons
extension ConvenienceCompare on DisplayModes {
  /// Determines if the current instance is of type [DisplayModes.carousel]
  bool get isCarousel {
    return this == DisplayModes.carousel;
  }

  /// Determines if the current instance is of type [DisplayModes.list]
  bool get isList {
    return this == DisplayModes.list;
  }

  /// Determines if the current instance is of type [DisplayModes.featured]
  bool get isFeatured {
    return this == DisplayModes.featured;
  }
}
