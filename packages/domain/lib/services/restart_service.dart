import 'package:domain/domain.dart';
import 'package:domain/services/crud_service.dart';

/// Defines the behavior of a counter restart service.
abstract class CounterRestartService extends CrudService<CounterRestart> {
  /// Finds all restarts of a given counter.
  Future<List<CounterRestart>> findAllByCounter(
    TimeCounter counter, {
    String? sortBy,
  });
}
