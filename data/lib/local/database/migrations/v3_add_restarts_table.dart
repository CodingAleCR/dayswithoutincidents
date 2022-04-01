import 'dart:async';

import 'package:data/local/database/entities/restart.entity.dart';
import 'package:data/local/database/entities/time_counter.entity.dart';
import 'package:data/local/database/support/migration.dart';
import 'package:sqflite/sqflite.dart';

/// Adds initial time_counters table to provide SQLite storage.
/// This will allow multiple counter support.
class V3AddRestartsTable extends Migration {
  @override
  FutureOr<void> up(Database db) async {
    await _createRestartsTable(db);
    await _addThemeColumn2CountersTable(db);
  }

  @override
  FutureOr<void> down(Database db) async {
    await _dropThemeColumn2CountersTable(db);
    await _dropRestartsTable(db);
  }

  _createRestartsTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute("""
        CREATE TABLE ${CounterRestartEntity.tablename} (
          ${CounterRestartEntity.ID} TEXT NOT NULL PRIMARY KEY,
          ${CounterRestartEntity.COUNTER_ID} TEXT NOT NULL,
          ${CounterRestartEntity.STARTED_AT} TEXT NOT NULL,
          ${CounterRestartEntity.RESTARTED_AT} TEXT NOT NULL,
          FOREIGN KEY (${CounterRestartEntity.COUNTER_ID})
            REFERENCES ${TimeCounterEntity.tablename} (${TimeCounterEntity.ID}) 
            ON UPDATE CASCADE 
            ON DELETE CASCADE
        )
      """);
    });
  }

  _addThemeColumn2CountersTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute("""
        ALTER TABLE ${TimeCounterEntity.tablename} 
          ADD COLUMN ${TimeCounterEntity.THEME} text;
      """);
    });
  }

  _dropThemeColumn2CountersTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute("""
       PRAGMA foreign_keys=off;
      """);

      await txn.execute("""
        DROP TABLE IF EXISTS _${TimeCounterEntity.tablename}_old
      """);

      await txn.execute("""
       ALTER TABLE ${TimeCounterEntity.tablename} 
          RENAME TO _${TimeCounterEntity.tablename}_old;
      """);

      await txn.execute("""
        CREATE TABLE ${TimeCounterEntity.tablename} (
          ${TimeCounterEntity.ID} TEXT NOT NULL PRIMARY KEY,
          ${TimeCounterEntity.TITLE} TEXT,
          ${TimeCounterEntity.CREATED_AT} TEXT
        )
      """);

      await txn.execute("""
        INSERT INTO ${TimeCounterEntity.tablename} (${TimeCounterEntity.ID}, ${TimeCounterEntity.TITLE}, ${TimeCounterEntity.CREATED_AT})
          SELECT ${TimeCounterEntity.ID}, ${TimeCounterEntity.TITLE}, ${TimeCounterEntity.CREATED_AT}
          FROM _${TimeCounterEntity.tablename}_old;
      """);

      await txn.execute("""
        DROP TABLE IF EXISTS _${TimeCounterEntity.tablename}_old
      """);

      await txn.execute("""
       PRAGMA foreign_keys=on;
      """);
    });
  }

  _dropRestartsTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute("""
        DROP TABLE IF EXISTS ${CounterRestartEntity.tablename}
      """);
    });
  }
}
