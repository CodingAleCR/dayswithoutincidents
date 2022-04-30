import 'package:data/local/database/entities/entities.dart';
import 'package:data/local/database/support/support.dart';
import 'package:domain/domain.dart';

/// Implementation of database repository for a CounterRestart
class TimeCounterRepository extends Repository<TimeCounter, TimeCounterEntity> {
  @override
  String get tablename => TimeCounterEntity.tablename;

  @override
  TimeCounterEntity parseMap(Map<String, Object?> map) =>
      TimeCounterEntity.fromDatabase(map);
}
