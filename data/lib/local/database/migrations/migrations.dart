import 'package:data/local/database/support/migration.dart';

import 'v1_initial_database.dart';
import 'v2_fix_local_database.dart';
import 'v3_add_restarts_table.dart';

final Map<int, Migration> migrations = {
  1: V1InitialDatabase(),
  2: V2FixLocalDatabase(),
  3: V3AddRestartsTable(),
};