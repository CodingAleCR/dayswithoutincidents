import 'dart:io';

import 'package:data/local/database/constants/constants.dart';
import 'package:data/local/database/migrations/migrations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite/sqflite.dart';

export 'constants/constants.dart';
export 'entities/entities.dart';
export 'migrations/migrations.dart';
export 'repositories/repositories.dart';
export 'support/support.dart';

_onConfigure(Database db) async {
  // Adds support for cascade delete
  await db.execute("PRAGMA foreign_keys = ON");
}

_onUpgrade(Database db, int oldVersion, int newVersion) async {
  try {
    int pendingQty = newVersion - oldVersion;
    List<int> pendingMigrations = List.generate(pendingQty, (i) => i + 1);

    await Future.forEach<int>(pendingMigrations, (currentVersion) async {
      await migrations[currentVersion]?.up(db);
    });
  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}

_onDowngrade(Database db, int oldVersion, int newVersion) async {
  try {
    int pendingQty = newVersion - oldVersion;
    List<int> pendingMigrations = List.generate(pendingQty, (i) => i + 1);

    await Future.forEach<int>(pendingMigrations, (currentVersion) async {
      await migrations[currentVersion]?.down(db);
    });
  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}

Future<Database> openDWIDatabase() async {
  var databasesPath = await getDatabasesPath();
  var path = databasesPath + '/' + kDatabaseName;

  await Directory(databasesPath).create(recursive: true);

  return await openDatabase(
    path,
    version: kDatabaseVersion,
    onConfigure: _onConfigure,
    onUpgrade: _onUpgrade,
    onDowngrade: _onDowngrade,
  );
}
