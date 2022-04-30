import 'package:data/data.dart';
import 'package:domain/domain.dart';

/// Service for handling counter restarts
class CounterRestartServiceImpl extends CounterRestartService {
  /// Constructor
  CounterRestartServiceImpl({
    CounterRestartRepository? repository,
  }) : _repository = repository ?? CounterRestartRepository();

  final CounterRestartRepository _repository;
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
  Future<CounterRestart> save(CounterRestart model) async {
    final entity = CounterRestartEntity.fromModel(model);
    await _repository.save(entity);

    return model;
  }

  @override
  Future<List<CounterRestart>> findAllByCounter(TimeCounter counter) async {
    final countersEntities = await _repository.findAllByCounterId(counter.id);
    return countersEntities.map((entity) => entity.toModel()).toList();
  }
}
