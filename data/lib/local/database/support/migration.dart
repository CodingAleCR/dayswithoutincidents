import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class Migration {
  /// Handles schema creation.
  FutureOr<void> create(Database db);

  /// Handles schema upgrading from previous migration.
  FutureOr<void> up(Database db);

  /// Handles schema downgrading to previous migration.
  FutureOr<void> down(Database db);
}
