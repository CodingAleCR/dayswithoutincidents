import 'package:data/local/database/entities/entities.dart';
import 'package:data/local/database/support/support.dart';

class TimeCounterRepository extends Repository<TimeCounterEntity> {
  @override
  String tablename() => "time_counters";

  @override
  TimeCounterEntity parseMap(Map<String, Object?> map) =>
      TimeCounterEntity.fromDatabase(map);
}
