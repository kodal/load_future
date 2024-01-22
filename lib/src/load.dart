import 'package:flutter/material.dart';

typedef LoadWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
  bool isLoading,
);

class LoadBuilder extends StatefulWidget {
  const LoadBuilder({
    Key? key,
    required this.child,
    required this.builder,
  }) : super(key: key);

  final Widget child;
  final LoadWidgetBuilder builder;

  @override
  State<LoadBuilder> createState() => LoadState();

  static LoadState of(BuildContext context) =>
      context.findAncestorStateOfType<LoadState>()!;
}

class LoadState extends State<LoadBuilder> {
  bool isLoading = false;

  Future<T> load<T>(Future<T> future) {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      future.whenComplete(() {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
    return future;
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.child,
        isLoading,
      );
}

extension LoadContext on BuildContext {
  Future<T> load<T>(Future<T> future) => LoadBuilder.of(this).load<T>(future);

  Future<T> loadRoot<T>(Future<T> future) =>
      findRootAncestorStateOfType<LoadState>()!.load<T>(future);
}
