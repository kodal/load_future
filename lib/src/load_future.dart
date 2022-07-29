import 'dart:async';

import 'package:async/async.dart';

import 'load_result.dart';

class LoadFuture<T> extends DelegatingFuture<T> {
  bool isComplete = false;

  LoadFuture(Future<T> future): super(future);

  late Stream<Result<T>> resultStream = _getResult().asBroadcastStream();

  Stream<Result<T>> _getResult() async* {
    if (!isComplete) {
      yield LoadResult();
    }
    yield await Result.capture(this);
  }

  @override
  Future<T> whenComplete(FutureOr Function() action) async {
    isComplete = true;
    return super.whenComplete(action);
  }

  @override
  Future<S> then<S>(FutureOr<S> Function(T p1) onValue,
      {Function? onError}) async {
    isComplete = true;
    return super.then(onValue, onError: onError);
  }

  @override
  Future<T> catchError(Function onError,
      {bool Function(Object error)? test}) async {
    isComplete = true;
    return super.catchError(onError, test: test);
  }
}
