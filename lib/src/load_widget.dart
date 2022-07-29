import 'package:flutter/material.dart';
import 'package:load_future/src/load_context.dart';

class LoadWidget extends InheritedWidget {
  final Widget indicator;

  LoadWidget({
    Key? key,
    required GlobalKey<NavigatorState> navigatorKey,
    this.indicator = const Center(child: CircularProgressIndicator()),
    required Widget child,
  }) : super(
          key: key,
          child: LoadContext(
            navigatorKey: navigatorKey,
            child: child,
          ),
        );

  static LoadWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LoadWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant LoadWidget oldWidget) =>
      indicator != oldWidget.indicator;
}
