import 'dart:async';

import 'package:async/async.dart';

class LoadResult implements Result<Never> {
  static final _load = LoadResult._internal();

  factory LoadResult() {
    return _load;
  }

  static Stream<Result<T>> capture<T>(Future<T> future) async* {
    yield LoadResult();
    yield await Result.capture(future);
  }

  LoadResult._internal();

  @override
  ErrorResult? get asError => null;

  @override
  Future<Never> get asFuture => throw TypeError();

  @override
  ValueResult<Never>? get asValue => null;

  @override
  bool get isError => false;

  @override
  bool get isValue => false;

  @override
  void complete(Completer completer) {
    completer.complete(null);
  }

  @override
  void addTo(EventSink sink) {
    sink.add(null);
  }
}
