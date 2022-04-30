import 'package:data/data.dart';
import 'package:domain/domain.dart';

/// Service that handles operations for time counters.
class TimeCounterServiceImpl extends TimeCounterService {
  /// Constructor
  TimeCounterServiceImpl({TimeCounterRepository? repository})
      : _repository = repository ?? TimeCounterRepository();

  final TimeCounterRepository _repository;
  @override
  Future<void> deleteById(String uuid) async {
    await _repository.deleteById(uuid);
  }

  @override
  Future<List<TimeCounter>> findAll() async {
    final countersEntities = await _repository.findAll();
    return countersEntities.map((entity) => entity.toModel()).toList();
  }

  @override
  Future<TimeCounter> findById(String uuid) async {
    final entity = await _repository.findById(uuid);
    return entity.toModel();
  }

  @override
  Future<TimeCounter> save(TimeCounter model) async {
    final entity = TimeCounterEntity.fromModel(model);
    await _repository.save(entity);

    return model;
  }
}
