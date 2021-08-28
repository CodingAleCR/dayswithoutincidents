import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

class TimeCounterServiceImpl extends TimeCounterService {
  final TimeCounterRepository _repository;

  TimeCounterServiceImpl({TimeCounterRepository? repository})
      : _repository = repository ?? TimeCounterRepository();

  @override
  Future<void> deleteById(UuidValue id) async {
    await _repository.deleteById(id.uuid);
  }

  @override
  Future<List<TimeCounter>> findAll() async {
    final countersEntities = await _repository.findAll();
    return countersEntities.map((entity) => entity.toModel()).toList();
  }

  @override
  Future<TimeCounter> findById(UuidValue id) async {
    final entity = await _repository.findById(id.uuid);
    return entity.toModel();
  }

  @override
  Future<TimeCounter> save(TimeCounter counter) async {
    final entity = TimeCounterEntity.fromModel(counter);
    await _repository.save(entity);

    return counter;
  }
}
