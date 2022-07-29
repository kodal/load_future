import 'package:flutter/widgets.dart';

GlobalKey<NavigatorState>? loadNavigatorKey;

class LoadContext extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const LoadContext({
    Key? key,
    required this.child,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  State<LoadContext> createState() => _LoadContextState();
}

class _LoadContextState extends State<LoadContext> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    loadNavigatorKey = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadContext oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadNavigatorKey = widget.navigatorKey;
  }
}
