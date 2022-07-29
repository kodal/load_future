import 'package:flutter/material.dart';

import 'load_widget.dart';

class LoadDialog<T> extends StatefulWidget {
  final Future<T> future;

  const LoadDialog(this.future, {Key? key}) : super(key: key);

  @override
  State<LoadDialog> createState() => _LoadDialogState<T>();
}

class _LoadDialogState<T> extends State<LoadDialog> {
  @override
  void initState() {
    super.initState();
    widget.future.then((value) {
      Navigator.pop(context, Future.value(value as T));
    }).catchError((e, s) {
      Navigator.pop(context, Future<T>.error(e, s));
    });
  }

  @override
  Widget build(BuildContext context) => LoadWidget.of(context).indicator;
}
