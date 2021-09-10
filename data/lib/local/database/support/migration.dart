import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class Migration {
  /// Hook that handles schema upgrading from previous migration.
  FutureOr<void> up(Database db);

  /// Hook that handles schema downgrading to previous migration.
  FutureOr<void> down(Database db);

  /// Execution method for migrations handling.
  FutureOr<void> executeUp(Database db) async {
    await up(db);
  }

  /// Execution method for migrations handling.
  FutureOr<void> executeDown(Database db) async {
    await down(db);
  }
}
