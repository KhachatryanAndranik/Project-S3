import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_app/app/library_app.dart';
import 'package:library_app/app/register_app_dependencies.dart';
import 'package:library_app/app/restart_widget.dart';
import 'package:library_app/shared.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final di = GetItDI();

      await registerAppSharedDependencies(
        di: di,
      );

      runApp(
        RestartWidget(
          child: LibraryApp(
            di: di,
          ),
          onBeforeRestart: () async {},
        ),
      );
    },
    (_, StackTrace __) {},
  );
}