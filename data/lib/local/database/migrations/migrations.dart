import 'package:data/local/database/support/migration.dart';

import 'v1_initial_database.dart';

final Map<int, Migration> migrations = {
  1: V1InitialDatabase(),
};
