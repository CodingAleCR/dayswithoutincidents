import 'dart:async';

import 'package:data/local/database/database.dart';
import 'package:domain/domain.dart';
import 'package:sqflite/sqflite.dart';

/// Fixes issues where the local database
/// can't obtain, reset or edit a counter's information
class V2FixLocalDatabase extends Migration {
  @override
  FutureOr<void> up(Database db) async {
    // Fetch all local counters
    final maps = await db.query(
      TimeCounterEntity.tablename,
      columns: null,
    );

    TimeCounterEntity firstCounter =
        TimeCounterEntity.fromModel(TimeCounter.empty);
    // If more than 1, then select the first one.
    if (maps.length > 1) {
      firstCounter = TimeCounterEntity.fromDatabase(maps.first);
    }

    // Delete all counters
    await db.delete(
      TimeCounterEntity.tablename,
    );

    // Just recreate first.
    await db.insert(
      TimeCounterEntity.tablename,
      {
        TimeCounterEntity.ID: firstCounter.uuid,
        TimeCounterEntity.TITLE: firstCounter.title,
        TimeCounterEntity.CREATED_AT: firstCounter.createdAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  FutureOr<void> down(Database db) async {
    // Not implemented
  }
}
