import 'package:data/data.dart';
import 'package:domain/domain.dart';

class CounterRestartServiceImpl extends CounterRestartService {
  final CounterRestartRepository _repository;

  CounterRestartServiceImpl({CounterRestartRepository? repository})
      : _repository = repository ?? CounterRestartRepository();

  @override
  Future<void> deleteById(String uuid) async {
    await _repository.deleteById(uuid);
  }

  @override
  Future<List<CounterRestart>> findAll() async {
    final countersEntities = await _repository.findAll();
    return countersEntities.map((entity) => entity.toModel()).toList();
  }

  @override
  Future<CounterRestart> findById(String uuid) async {
    final entity = await _repository.findById(uuid);
    return entity.toModel();
  }

  @override
  Future<CounterRestart> save(CounterRestart counter) async {
    final entity = CounterRestartEntity.fromModel(counter);
    await _repository.save(entity);

    return counter;
  }

  @override
  Future<List<CounterRestart>> findAllByCounter(TimeCounter counter) async {
    final countersEntities = await _repository.findAllByCounterId(counter.id);
    return countersEntities.map((entity) => entity.toModel()).toList();
  }
}
