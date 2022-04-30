/// Environment configuration.
class EnvironmentConfig {
  /// Wiredash project id.
  static const wiredashProjectId = String.fromEnvironment(
    'DWI_WIREDASH_PROJECT_ID',
  );

  /// Wiredash secret key
  static const wiredashSecret = String.fromEnvironment(
    'DWI_WIREDASH_SECRET',
  );
}
