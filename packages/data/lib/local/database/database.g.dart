// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class TimeCounters extends Table with TableInfo<TimeCounters, TimeCounter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TimeCounters(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
      'theme', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'DEFAULT \'plain_light\'',
      defaultValue: const CustomExpression('\'plain_light\''));
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt, theme];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_counters';
  @override
  VerificationContext validateIntegrity(Insertable<TimeCounter> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('theme')) {
      context.handle(
          _themeMeta, theme.isAcceptableOrUnknown(data['theme']!, _themeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeCounter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeCounter(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      theme: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme']),
    );
  }

  @override
  TimeCounters createAlias(String alias) {
    return TimeCounters(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TimeCounter extends DataClass implements Insertable<TimeCounter> {
  final String id;
  final String? title;
  final String? createdAt;
  final String? theme;
  const TimeCounter({required this.id, this.title, this.createdAt, this.theme});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || theme != null) {
      map['theme'] = Variable<String>(theme);
    }
    return map;
  }

  TimeCountersCompanion toCompanion(bool nullToAbsent) {
    return TimeCountersCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      theme:
          theme == null && nullToAbsent ? const Value.absent() : Value(theme),
    );
  }

  factory TimeCounter.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeCounter(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<String?>(json['created_at']),
      theme: serializer.fromJson<String?>(json['theme']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'created_at': serializer.toJson<String?>(createdAt),
      'theme': serializer.toJson<String?>(theme),
    };
  }

  TimeCounter copyWith(
          {String? id,
          Value<String?> title = const Value.absent(),
          Value<String?> createdAt = const Value.absent(),
          Value<String?> theme = const Value.absent()}) =>
      TimeCounter(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        theme: theme.present ? theme.value : this.theme,
      );
  TimeCounter copyWithCompanion(TimeCountersCompanion data) {
    return TimeCounter(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      theme: data.theme.present ? data.theme.value : this.theme,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeCounter(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('theme: $theme')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt, theme);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeCounter &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.theme == this.theme);
}

class TimeCountersCompanion extends UpdateCompanion<TimeCounter> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> createdAt;
  final Value<String?> theme;
  final Value<int> rowid;
  const TimeCountersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.theme = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeCountersCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.theme = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<TimeCounter> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? createdAt,
    Expression<String>? theme,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (theme != null) 'theme': theme,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeCountersCompanion copyWith(
      {Value<String>? id,
      Value<String?>? title,
      Value<String?>? createdAt,
      Value<String?>? theme,
      Value<int>? rowid}) {
    return TimeCountersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      theme: theme ?? this.theme,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeCountersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('theme: $theme, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CounterWidgets extends Table
    with TableInfo<CounterWidgets, CounterWidget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CounterWidgets(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _counterIdMeta =
      const VerificationMeta('counterId');
  late final GeneratedColumn<String> counterId = GeneratedColumn<String>(
      'counter_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _widgetIdMeta =
      const VerificationMeta('widgetId');
  late final GeneratedColumn<String> widgetId = GeneratedColumn<String>(
      'widget_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, counterId, widgetId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'counter_widgets';
  @override
  VerificationContext validateIntegrity(Insertable<CounterWidget> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('counter_id')) {
      context.handle(_counterIdMeta,
          counterId.isAcceptableOrUnknown(data['counter_id']!, _counterIdMeta));
    } else if (isInserting) {
      context.missing(_counterIdMeta);
    }
    if (data.containsKey('widget_id')) {
      context.handle(_widgetIdMeta,
          widgetId.isAcceptableOrUnknown(data['widget_id']!, _widgetIdMeta));
    } else if (isInserting) {
      context.missing(_widgetIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CounterWidget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CounterWidget(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      counterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}counter_id'])!,
      widgetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}widget_id'])!,
    );
  }

  @override
  CounterWidgets createAlias(String alias) {
    return CounterWidgets(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(counter_id)REFERENCES time_counters(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class CounterWidget extends DataClass implements Insertable<CounterWidget> {
  final String id;
  final String counterId;
  final String widgetId;
  const CounterWidget(
      {required this.id, required this.counterId, required this.widgetId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['counter_id'] = Variable<String>(counterId);
    map['widget_id'] = Variable<String>(widgetId);
    return map;
  }

  CounterWidgetsCompanion toCompanion(bool nullToAbsent) {
    return CounterWidgetsCompanion(
      id: Value(id),
      counterId: Value(counterId),
      widgetId: Value(widgetId),
    );
  }

  factory CounterWidget.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CounterWidget(
      id: serializer.fromJson<String>(json['id']),
      counterId: serializer.fromJson<String>(json['counter_id']),
      widgetId: serializer.fromJson<String>(json['widget_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'counter_id': serializer.toJson<String>(counterId),
      'widget_id': serializer.toJson<String>(widgetId),
    };
  }

  CounterWidget copyWith({String? id, String? counterId, String? widgetId}) =>
      CounterWidget(
        id: id ?? this.id,
        counterId: counterId ?? this.counterId,
        widgetId: widgetId ?? this.widgetId,
      );
  CounterWidget copyWithCompanion(CounterWidgetsCompanion data) {
    return CounterWidget(
      id: data.id.present ? data.id.value : this.id,
      counterId: data.counterId.present ? data.counterId.value : this.counterId,
      widgetId: data.widgetId.present ? data.widgetId.value : this.widgetId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CounterWidget(')
          ..write('id: $id, ')
          ..write('counterId: $counterId, ')
          ..write('widgetId: $widgetId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, counterId, widgetId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CounterWidget &&
          other.id == this.id &&
          other.counterId == this.counterId &&
          other.widgetId == this.widgetId);
}

class CounterWidgetsCompanion extends UpdateCompanion<CounterWidget> {
  final Value<String> id;
  final Value<String> counterId;
  final Value<String> widgetId;
  final Value<int> rowid;
  const CounterWidgetsCompanion({
    this.id = const Value.absent(),
    this.counterId = const Value.absent(),
    this.widgetId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CounterWidgetsCompanion.insert({
    required String id,
    required String counterId,
    required String widgetId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        counterId = Value(counterId),
        widgetId = Value(widgetId);
  static Insertable<CounterWidget> custom({
    Expression<String>? id,
    Expression<String>? counterId,
    Expression<String>? widgetId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (counterId != null) 'counter_id': counterId,
      if (widgetId != null) 'widget_id': widgetId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CounterWidgetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? counterId,
      Value<String>? widgetId,
      Value<int>? rowid}) {
    return CounterWidgetsCompanion(
      id: id ?? this.id,
      counterId: counterId ?? this.counterId,
      widgetId: widgetId ?? this.widgetId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (counterId.present) {
      map['counter_id'] = Variable<String>(counterId.value);
    }
    if (widgetId.present) {
      map['widget_id'] = Variable<String>(widgetId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CounterWidgetsCompanion(')
          ..write('id: $id, ')
          ..write('counterId: $counterId, ')
          ..write('widgetId: $widgetId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CounterRestarts extends Table
    with TableInfo<CounterRestarts, CounterRestart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CounterRestarts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _counterIdMeta =
      const VerificationMeta('counterId');
  late final GeneratedColumn<String> counterId = GeneratedColumn<String>(
      'counter_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
      'started_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _restartedAtMeta =
      const VerificationMeta('restartedAt');
  late final GeneratedColumn<String> restartedAt = GeneratedColumn<String>(
      'restarted_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, counterId, startedAt, restartedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'counter_restarts';
  @override
  VerificationContext validateIntegrity(Insertable<CounterRestart> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('counter_id')) {
      context.handle(_counterIdMeta,
          counterId.isAcceptableOrUnknown(data['counter_id']!, _counterIdMeta));
    } else if (isInserting) {
      context.missing(_counterIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('restarted_at')) {
      context.handle(
          _restartedAtMeta,
          restartedAt.isAcceptableOrUnknown(
              data['restarted_at']!, _restartedAtMeta));
    } else if (isInserting) {
      context.missing(_restartedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CounterRestart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CounterRestart(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      counterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}counter_id'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}started_at'])!,
      restartedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}restarted_at'])!,
    );
  }

  @override
  CounterRestarts createAlias(String alias) {
    return CounterRestarts(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(counter_id)REFERENCES time_counters(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class CounterRestart extends DataClass implements Insertable<CounterRestart> {
  final String id;
  final String counterId;
  final String startedAt;
  final String restartedAt;
  const CounterRestart(
      {required this.id,
      required this.counterId,
      required this.startedAt,
      required this.restartedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['counter_id'] = Variable<String>(counterId);
    map['started_at'] = Variable<String>(startedAt);
    map['restarted_at'] = Variable<String>(restartedAt);
    return map;
  }

  CounterRestartsCompanion toCompanion(bool nullToAbsent) {
    return CounterRestartsCompanion(
      id: Value(id),
      counterId: Value(counterId),
      startedAt: Value(startedAt),
      restartedAt: Value(restartedAt),
    );
  }

  factory CounterRestart.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CounterRestart(
      id: serializer.fromJson<String>(json['id']),
      counterId: serializer.fromJson<String>(json['counter_id']),
      startedAt: serializer.fromJson<String>(json['started_at']),
      restartedAt: serializer.fromJson<String>(json['restarted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'counter_id': serializer.toJson<String>(counterId),
      'started_at': serializer.toJson<String>(startedAt),
      'restarted_at': serializer.toJson<String>(restartedAt),
    };
  }

  CounterRestart copyWith(
          {String? id,
          String? counterId,
          String? startedAt,
          String? restartedAt}) =>
      CounterRestart(
        id: id ?? this.id,
        counterId: counterId ?? this.counterId,
        startedAt: startedAt ?? this.startedAt,
        restartedAt: restartedAt ?? this.restartedAt,
      );
  CounterRestart copyWithCompanion(CounterRestartsCompanion data) {
    return CounterRestart(
      id: data.id.present ? data.id.value : this.id,
      counterId: data.counterId.present ? data.counterId.value : this.counterId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      restartedAt:
          data.restartedAt.present ? data.restartedAt.value : this.restartedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CounterRestart(')
          ..write('id: $id, ')
          ..write('counterId: $counterId, ')
          ..write('startedAt: $startedAt, ')
          ..write('restartedAt: $restartedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, counterId, startedAt, restartedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CounterRestart &&
          other.id == this.id &&
          other.counterId == this.counterId &&
          other.startedAt == this.startedAt &&
          other.restartedAt == this.restartedAt);
}

class CounterRestartsCompanion extends UpdateCompanion<CounterRestart> {
  final Value<String> id;
  final Value<String> counterId;
  final Value<String> startedAt;
  final Value<String> restartedAt;
  final Value<int> rowid;
  const CounterRestartsCompanion({
    this.id = const Value.absent(),
    this.counterId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.restartedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CounterRestartsCompanion.insert({
    required String id,
    required String counterId,
    required String startedAt,
    required String restartedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        counterId = Value(counterId),
        startedAt = Value(startedAt),
        restartedAt = Value(restartedAt);
  static Insertable<CounterRestart> custom({
    Expression<String>? id,
    Expression<String>? counterId,
    Expression<String>? startedAt,
    Expression<String>? restartedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (counterId != null) 'counter_id': counterId,
      if (startedAt != null) 'started_at': startedAt,
      if (restartedAt != null) 'restarted_at': restartedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CounterRestartsCompanion copyWith(
      {Value<String>? id,
      Value<String>? counterId,
      Value<String>? startedAt,
      Value<String>? restartedAt,
      Value<int>? rowid}) {
    return CounterRestartsCompanion(
      id: id ?? this.id,
      counterId: counterId ?? this.counterId,
      startedAt: startedAt ?? this.startedAt,
      restartedAt: restartedAt ?? this.restartedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (counterId.present) {
      map['counter_id'] = Variable<String>(counterId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (restartedAt.present) {
      map['restarted_at'] = Variable<String>(restartedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CounterRestartsCompanion(')
          ..write('id: $id, ')
          ..write('counterId: $counterId, ')
          ..write('startedAt: $startedAt, ')
          ..write('restartedAt: $restartedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final TimeCounters timeCounters = TimeCounters(this);
  late final CounterWidgets counterWidgets = CounterWidgets(this);
  late final CounterRestarts counterRestarts = CounterRestarts(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [timeCounters, counterWidgets, counterRestarts];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('time_counters',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('counter_widgets', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('time_counters',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('counter_widgets', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('time_counters',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('counter_restarts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('time_counters',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('counter_restarts', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

typedef $TimeCountersCreateCompanionBuilder = TimeCountersCompanion Function({
  required String id,
  Value<String?> title,
  Value<String?> createdAt,
  Value<String?> theme,
  Value<int> rowid,
});
typedef $TimeCountersUpdateCompanionBuilder = TimeCountersCompanion Function({
  Value<String> id,
  Value<String?> title,
  Value<String?> createdAt,
  Value<String?> theme,
  Value<int> rowid,
});

class $TimeCountersTableManager extends RootTableManager<
    _$AppDatabase,
    TimeCounters,
    TimeCounter,
    $TimeCountersFilterComposer,
    $TimeCountersOrderingComposer,
    $TimeCountersCreateCompanionBuilder,
    $TimeCountersUpdateCompanionBuilder> {
  $TimeCountersTableManager(_$AppDatabase db, TimeCounters table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $TimeCountersFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $TimeCountersOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> theme = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeCountersCompanion(
            id: id,
            title: title,
            createdAt: createdAt,
            theme: theme,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> title = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String?> theme = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeCountersCompanion.insert(
            id: id,
            title: title,
            createdAt: createdAt,
            theme: theme,
            rowid: rowid,
          ),
        ));
}

class $TimeCountersFilterComposer
    extends FilterComposer<_$AppDatabase, TimeCounters> {
  $TimeCountersFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get theme => $state.composableBuilder(
      column: $state.table.theme,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $TimeCountersOrderingComposer
    extends OrderingComposer<_$AppDatabase, TimeCounters> {
  $TimeCountersOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get theme => $state.composableBuilder(
      column: $state.table.theme,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $CounterWidgetsCreateCompanionBuilder = CounterWidgetsCompanion
    Function({
  required String id,
  required String counterId,
  required String widgetId,
  Value<int> rowid,
});
typedef $CounterWidgetsUpdateCompanionBuilder = CounterWidgetsCompanion
    Function({
  Value<String> id,
  Value<String> counterId,
  Value<String> widgetId,
  Value<int> rowid,
});

class $CounterWidgetsTableManager extends RootTableManager<
    _$AppDatabase,
    CounterWidgets,
    CounterWidget,
    $CounterWidgetsFilterComposer,
    $CounterWidgetsOrderingComposer,
    $CounterWidgetsCreateCompanionBuilder,
    $CounterWidgetsUpdateCompanionBuilder> {
  $CounterWidgetsTableManager(_$AppDatabase db, CounterWidgets table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $CounterWidgetsFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $CounterWidgetsOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> counterId = const Value.absent(),
            Value<String> widgetId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CounterWidgetsCompanion(
            id: id,
            counterId: counterId,
            widgetId: widgetId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String counterId,
            required String widgetId,
            Value<int> rowid = const Value.absent(),
          }) =>
              CounterWidgetsCompanion.insert(
            id: id,
            counterId: counterId,
            widgetId: widgetId,
            rowid: rowid,
          ),
        ));
}

class $CounterWidgetsFilterComposer
    extends FilterComposer<_$AppDatabase, CounterWidgets> {
  $CounterWidgetsFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get counterId => $state.composableBuilder(
      column: $state.table.counterId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get widgetId => $state.composableBuilder(
      column: $state.table.widgetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $CounterWidgetsOrderingComposer
    extends OrderingComposer<_$AppDatabase, CounterWidgets> {
  $CounterWidgetsOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get counterId => $state.composableBuilder(
      column: $state.table.counterId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get widgetId => $state.composableBuilder(
      column: $state.table.widgetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $CounterRestartsCreateCompanionBuilder = CounterRestartsCompanion
    Function({
  required String id,
  required String counterId,
  required String startedAt,
  required String restartedAt,
  Value<int> rowid,
});
typedef $CounterRestartsUpdateCompanionBuilder = CounterRestartsCompanion
    Function({
  Value<String> id,
  Value<String> counterId,
  Value<String> startedAt,
  Value<String> restartedAt,
  Value<int> rowid,
});

class $CounterRestartsTableManager extends RootTableManager<
    _$AppDatabase,
    CounterRestarts,
    CounterRestart,
    $CounterRestartsFilterComposer,
    $CounterRestartsOrderingComposer,
    $CounterRestartsCreateCompanionBuilder,
    $CounterRestartsUpdateCompanionBuilder> {
  $CounterRestartsTableManager(_$AppDatabase db, CounterRestarts table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $CounterRestartsFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $CounterRestartsOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> counterId = const Value.absent(),
            Value<String> startedAt = const Value.absent(),
            Value<String> restartedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CounterRestartsCompanion(
            id: id,
            counterId: counterId,
            startedAt: startedAt,
            restartedAt: restartedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String counterId,
            required String startedAt,
            required String restartedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CounterRestartsCompanion.insert(
            id: id,
            counterId: counterId,
            startedAt: startedAt,
            restartedAt: restartedAt,
            rowid: rowid,
          ),
        ));
}

class $CounterRestartsFilterComposer
    extends FilterComposer<_$AppDatabase, CounterRestarts> {
  $CounterRestartsFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get counterId => $state.composableBuilder(
      column: $state.table.counterId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get restartedAt => $state.composableBuilder(
      column: $state.table.restartedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $CounterRestartsOrderingComposer
    extends OrderingComposer<_$AppDatabase, CounterRestarts> {
  $CounterRestartsOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get counterId => $state.composableBuilder(
      column: $state.table.counterId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get restartedAt => $state.composableBuilder(
      column: $state.table.restartedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $TimeCountersTableManager get timeCounters =>
      $TimeCountersTableManager(_db, _db.timeCounters);
  $CounterWidgetsTableManager get counterWidgets =>
      $CounterWidgetsTableManager(_db, _db.counterWidgets);
  $CounterRestartsTableManager get counterRestarts =>
      $CounterRestartsTableManager(_db, _db.counterRestarts);
}
