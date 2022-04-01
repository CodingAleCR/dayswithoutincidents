import 'package:data/data.dart';
import 'package:domain/domain.dart';

class TimeCounterServiceImpl extends TimeCounterService {
  final TimeCounterRepository _repository;

  TimeCounterServiceImpl({TimeCounterRepository? repository})
      : _repository = repository ?? TimeCounterRepository();

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
  Future<TimeCounter> save(TimeCounter counter) async {
    final entity = TimeCounterEntity.fromModel(counter);
    await _repository.save(entity);

    return counter;
  }
}
