import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/application/application.dart';

void main() async {
  runApp(
    RepositoryProvider<ThemeService>(
      create: (context) => ThemeServiceImpl(),
      child: DWIApplication(),
    ),
  );
}
