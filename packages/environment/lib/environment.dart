/// Shared configs for DWI
library environment;

/// Environment Configuration variables
abstract final class EnvironmentConfig {
  /// Feature Flags
  /// Enables custom views for counters like list view or featured view.
  static const bool ffCustomViewsEnabled =
      bool.fromEnvironment('FF_LIST_VIEW_ENABLED');

  /// Wiredash project id.
  static const wiredashProjectId = String.fromEnvironment(
    'DWI_WIREDASH_PROJECT_ID',
  );

  /// Wiredash secret key
  static const wiredashSecret = String.fromEnvironment(
    'DWI_WIREDASH_SECRET',
  );
}
