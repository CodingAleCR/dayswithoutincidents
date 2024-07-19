import 'package:data/local/database/constants/constants.dart';
import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {'schema.drift'},
)
class DWIDatabase extends _$DWIDatabase {
  DWIDatabase() : super(_openDatabase());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // This is similar to the `onUpgrade` callback from sqflite. When
        // migrating to drift, it should contain your existing migration logic.
        // You can access the raw database by using `customStatement`
      },
      beforeOpen: (details) async {
        // This is a good place to enable pragmas you expect, e.g.
        await customStatement('pragma foreign_keys = ON;');
      },
    );
  }

  Stream<List<TimeCounter>> watchAllCounters() {
    return select(timeCounters).watch();
  }

  static QueryExecutor _openDatabase() {
    return SqfliteQueryExecutor.inDatabaseFolder(path: kDatabaseName);
  }
}
