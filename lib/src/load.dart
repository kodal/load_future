import 'package:flutter/material.dart';
import 'package:load_future/src/load_context.dart';

import 'load_dialog.dart';

Future<T> load<T>(Future<T> future) {
  final navigatorKey = loadNavigatorKey;
  if (navigatorKey == null) {
    throw StateError('`navigatorKey` did not set in `LoadWidget`');
  }

  final context = navigatorKey.currentContext;
  if (context == null) {
    throw StateError(
      '`navigatorKey` did not set in `MaterialApp` or `CupertinoApp`',
    );
  }

  return showGeneralDialog<Future<T>>(
    context: context,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) => LoadDialog(future),
  ).then((value) => value!.then((value) => value));
}
