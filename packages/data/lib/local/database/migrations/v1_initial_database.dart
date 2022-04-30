import 'dart:async';

import 'package:data/local/database/entities/time_counter.entity.dart';
import 'package:data/local/database/support/migration.dart';
import 'package:sqflite/sqflite.dart';

/// Adds initial time_counters table to provide SQLite storage.
/// This will allow multiple counter support.
class V1InitialDatabase extends Migration {
  @override
  FutureOr<void> up(Database db) async {
    await _createCountersTable(db);
  }

  @override
  FutureOr<void> down(Database db) async {
    await _dropCountersTable(db);
  }

  Future<void> _createCountersTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute(
        '''
        CREATE TABLE time_counters (
          ${TimeCounterEntity.kId} TEXT NOT NULL PRIMARY KEY,
          ${TimeCounterEntity.kTitle} TEXT,
          ${TimeCounterEntity.kCreatedAt} TEXT
        )
      ''',
      );
    });
  }

  Future<void> _dropCountersTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute(
        '''
        DROP TABLE IF EXISTS time_counters
      ''',
      );
    });
  }
}
