import 'dart:async';

import 'package:data/local/database/entities/time_counter.entity.dart';
import 'package:data/local/database/support/migration.dart';
import 'package:data/local/shared_preferences/providers/time_counter_preference_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Adds initial time_counters table to provide SQLite storage.
/// This will allow multiple counter support.
class V1InitialDatabase extends Migration {
  @override
  FutureOr<void> create(Database db) async {
    await _createCountersTable(db);
    await _migrateCurrentCounter(db);
  }

  @override
  FutureOr<void> up(Database db) async {
    await _createCountersTable(db);
  }

  @override
  FutureOr<void> down(Database db) async {
    await _dropCountersTable(db);
  }

  _createCountersTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute("""
        CREATE TABLE time_counters (
          ${TimeCounterEntity.ID} TEXT PRIMARY KEY,
          ${TimeCounterEntity.TITLE} TEXT,
          ${TimeCounterEntity.CREATED_AT} TEXT
        )
      """);
    });
  }

  _migrateCurrentCounter(Database db) async {
    final provider = TimeCounterSharedPreferenceProvider();
    final counter = await provider.getCounter();
    final entity = TimeCounterEntity.fromModel(counter);
    await db.transaction((txn) async {
      await txn.insert(
        "time_counters",
        entity.toDatabaseMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    });
  }

  _dropCountersTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute("""
        DROP TABLE IF EXISTS time_counters
      """);
    });
  }
}
