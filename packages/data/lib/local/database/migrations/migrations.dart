import 'package:data/local/database/migrations/v1_initial_database.dart';
import 'package:data/local/database/migrations/v2_fix_local_database.dart';
import 'package:data/local/database/migrations/v3_add_restarts_table.dart';
import 'package:data/local/database/support/migration.dart';

/// Maps each migration to its implementation.
final Map<int, Migration> migrations = {
  1: V1InitialDatabase(),
  2: V2FixLocalDatabase(),
  3: V3AddRestartsTable(),
};
