import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
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

  Future<void> _createRestartsTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute(
        '''
        CREATE TABLE ${CounterRestartEntity.tablename} (
          ${CounterRestartEntity.kId} TEXT NOT NULL PRIMARY KEY,
          ${CounterRestartEntity.kCounterId} TEXT NOT NULL,
          ${CounterRestartEntity.kStartedAt} TEXT NOT NULL,
          ${CounterRestartEntity.kRestartedAt} TEXT NOT NULL,
          FOREIGN KEY (${CounterRestartEntity.kCounterId})
            REFERENCES ${TimeCounterEntity.tablename} (${TimeCounterEntity.kId}) 
            ON UPDATE CASCADE 
            ON DELETE CASCADE
        )
      ''',
      );
    });
  }

  Future<void> _addThemeColumn2CountersTable(Database db) async {
    const currentTheme = AppTheme.happyCyan;

    await db.transaction((txn) async {
      await txn.execute(
        """
        ALTER TABLE ${TimeCounterEntity.tablename} 
          ADD COLUMN ${TimeCounterEntity.kTheme} text DEFAULT '${currentTheme.key()}';
      """,
      );
    });
  }

  Future<void> _dropThemeColumn2CountersTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute(
        '''
       PRAGMA foreign_keys=off;
      ''',
      );

      await txn.execute(
        '''
        DROP TABLE IF EXISTS _${TimeCounterEntity.tablename}_old
      ''',
      );

      await txn.execute(
        '''
       ALTER TABLE ${TimeCounterEntity.tablename} 
          RENAME TO _${TimeCounterEntity.tablename}_old;
      ''',
      );

      await txn.execute(
        '''
        CREATE TABLE ${TimeCounterEntity.tablename} (
          ${TimeCounterEntity.kId} TEXT NOT NULL PRIMARY KEY,
          ${TimeCounterEntity.kTitle} TEXT,
          ${TimeCounterEntity.kCreatedAt} TEXT
        )
      ''',
      );

      await txn.execute(
        '''
        INSERT INTO ${TimeCounterEntity.tablename} (${TimeCounterEntity.kId}, ${TimeCounterEntity.kTitle}, ${TimeCounterEntity.kCreatedAt})
          SELECT ${TimeCounterEntity.kId}, ${TimeCounterEntity.kTitle}, ${TimeCounterEntity.kCreatedAt}
          FROM _${TimeCounterEntity.tablename}_old;
      ''',
      );

      await txn.execute(
        '''
        DROP TABLE IF EXISTS _${TimeCounterEntity.tablename}_old
      ''',
      );

      await txn.execute(
        '''
       PRAGMA foreign_keys=on;
      ''',
      );
    });
  }

  Future<void> _dropRestartsTable(Database db) async {
    await db.transaction((txn) async {
      await txn.execute(
        '''
        DROP TABLE IF EXISTS ${CounterRestartEntity.tablename}
      ''',
      );
    });
  }
}
