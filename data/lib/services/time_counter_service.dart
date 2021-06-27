import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

class TimeCounterServiceImpl extends TimeCounterService {
  final TimeCounterRepository _repository;

  TimeCounterServiceImpl({TimeCounterRepository? repository})
      : _repository = repository ?? TimeCounterRepository();

  @override
  Future<void> deleteById(Uuid id) async {
    await _repository.deleteById(id.v4());
  }

  @override
  Future<List<TimeCounter>> findAll() async {
    final countersEntities = await _repository.findAll();
    return countersEntities.map((entity) => entity.toModel()).toList();
  }

  @override
  Future<TimeCounter> findById(Uuid id) async {
    final entity = await _repository.findById(id.v4());
    return entity.toModel();
  }

  @override
  Future<TimeCounter> save(TimeCounter counter) async {
    await _repository.save(TimeCounterEntity.fromModel(counter));

    return counter;
  }
}
