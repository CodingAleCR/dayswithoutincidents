import 'package:domain/domain.dart';

abstract class CounterRestartService extends CrudService<CounterRestart> {
  Future<List<CounterRestart>> findAllByCounter(TimeCounter counter);
}
