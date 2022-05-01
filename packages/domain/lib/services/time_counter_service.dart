import 'package:domain/domain.dart';
import 'package:domain/services/crud_service.dart';

/// Defines standard time counter service behaviors
abstract class TimeCounterService extends CrudService<TimeCounter> {
  /// Provides a [Stream] of all time counters.
  Stream<List<TimeCounter>> get allCounters;
}
