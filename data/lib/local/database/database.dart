import 'dart:io';

export 'constants/constants.dart';
export 'migrations/migrations.dart';
export 'repositories/repositories.dart';
export 'entities/entities.dart';
export 'support/support.dart';

import 'package:data/local/database/constants/constants.dart';
import 'package:data/local/database/migrations/migrations.dart';
import 'package:sqflite/sqflite.dart';

_onConfigure(Database db) async {
  // Adds support for cascade delete
  await db.execute("PRAGMA foreign_keys = ON");
}

_onCreate(Database db, int version) async {
  await migrations[version]?.create(db);
}

_onUpgrade(Database db, int oldVersion, int newVersion) async {
  int pendingQty = newVersion - oldVersion;
  List<int> pendingMigrations = List.generate(pendingQty, (i) => i + 1);

  await Future.forEach<int>(pendingMigrations, (versionDiff) async {
    await migrations[newVersion]?.up(db);
  });
}

_onDowngrade(Database db, int oldVersion, int newVersion) async {
  int pendingQty = newVersion - oldVersion;
  List<int> pendingMigrations = List.generate(pendingQty, (i) => i + 1);

  await Future.forEach<int>(pendingMigrations, (versionDiff) async {
    await migrations[newVersion]?.down(db);
  });
}

Future<Database> openDWIDatabase() async {
  var databasesPath = await getDatabasesPath();
  var path = databasesPath + '/' + kDatabaseName;

  await Directory(databasesPath).create(recursive: true);

  return await openDatabase(
    path,
    version: kDatabaseVersion,
    onConfigure: _onConfigure,
    onCreate: _onCreate,
    onUpgrade: _onUpgrade,
    onDowngrade: _onDowngrade,
  );
}
