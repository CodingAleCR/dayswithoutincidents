import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:rxdart/subjects.dart';

/// Service that handles operations for time counters.
class TimeCounterServiceImpl extends TimeCounterService {
  /// Constructor
  TimeCounterServiceImpl({TimeCounterRepository? repository})
      : _repository = repository ?? TimeCounterRepository();

  final TimeCounterRepository _repository;

  final _countersStreamController =
      BehaviorSubject<List<TimeCounter>>.seeded(const []);

  @override
  Stream<List<TimeCounter>> get allCounters =>
      _countersStreamController.asBroadcastStream();

  @override
  Future<void> deleteById(String uuid) async {
    await _repository.deleteById(uuid);

    _countersStreamController.add(await findAll());
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

    /// Update list.
    _countersStreamController.add(await findAll());

    return model;
  }
}
